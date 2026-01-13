import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import '../../data/db/db_manager.dart';
import '../../data/db/ledger/ledger_db.dart';
import '../../data/db/ledger/ledger_tables.dart';
import '../models/entry_models.dart';
import 'money_parser.dart';

class RecordService {
  RecordService._();
  static final RecordService instance = RecordService._();

  static const _uuid = Uuid();

  // ==========================================================
  // Create
  // ==========================================================
  Future<String> submitDraft({
    required String ledgerId,
    required EntryKind kind,
    required EntryDraft draft,
  }) async {
    final db = await DbManager.instance.ledger(ledgerId);

    final now = DateTime.now().millisecondsSinceEpoch;
    final occurredAtMs = _parseOccurredAtMs(draft.timeText);

    final amountMinor = MoneyParser.toMinor(draft.amount);
    if (amountMinor <= 0) {
      throw ArgumentError('金额必须大于 0');
    }

    final txnId = _uuid.v4();

    switch (kind) {
      case EntryKind.expense:
        await _insertExpense(db, txnId, amountMinor, occurredAtMs, now, draft);
        break;

      case EntryKind.income:
        await _insertIncome(db, txnId, amountMinor, occurredAtMs, now, draft);
        break;

      case EntryKind.transfer:
        await _insertTransfer(db, txnId, amountMinor, occurredAtMs, now, draft);
        break;
    }

    return txnId;
  }

  // ==========================================================
  // Edit: load / update / delete
  // ==========================================================

  /// 加载一条流水用于编辑（根据 txns.txn_type 返回对应 kind + draft）
  Future<({EntryKind kind, EntryDraft draft})> loadForEdit({
    required String ledgerId,
    required String entryId,
  }) async {
    final db = await DbManager.instance.ledger(ledgerId);

    final rows =
        await (db.select(db.txns)
              ..where(
                (t) => t.isDeleted.equals(false) & t.txnId.equals(entryId),
              )
              ..limit(1))
            .get();

    if (rows.isEmpty) {
      throw StateError('未找到该流水：$entryId');
    }

    final txn = rows.first;

    final kind = _entryKindFromTxnType(txn.txnType);
    final amountText = _minorToAmountText(txn.amountMinor);
    final timeText = _occurredAtToTimeText(txn.occurredAtMs);
    final remark = (txn.note ?? '').trim();

    if (kind == EntryKind.transfer) {
      final fromName = await _findAccountName(db, txn.fromAccountId);
      final toName = await _findAccountName(db, txn.toAccountId);

      final base = EntryDraft.initialTransfer();
      final draft = base.copyWith(
        amount: amountText,
        timeText: timeText,
        remark: remark,
        fromAccount: fromName ?? base.fromAccount,
        toAccount: toName ?? base.toAccount,
      );
      return (kind: kind, draft: draft);
    }

    // expense / income
    final accountName = await _findAccountName(db, txn.accountId);
    final catPath = await _findCategoryPath(db, txn.categoryId);

    final base = (kind == EntryKind.expense)
        ? EntryDraft.initialExpense()
        : EntryDraft.initialIncome();

    final draft = base.copyWith(
      amount: amountText,
      timeText: timeText,
      remark: remark,
      account: accountName ?? base.account,
      category: catPath ?? base.category,
    );

    return (kind: kind, draft: draft);
  }

  /// 更新一条现有流水（编辑保存）
  Future<void> updateDraft({
    required String ledgerId,
    required String entryId,
    required EntryKind kind,
    required EntryDraft draft,
  }) async {
    final db = await DbManager.instance.ledger(ledgerId);

    final now = DateTime.now().millisecondsSinceEpoch;
    final occurredAtMs = _parseOccurredAtMs(draft.timeText);

    final amountMinor = MoneyParser.toMinor(draft.amount);
    if (amountMinor <= 0) {
      throw ArgumentError('金额必须大于 0');
    }

    switch (kind) {
      case EntryKind.expense:
        await _updateExpense(
          db,
          entryId,
          amountMinor,
          occurredAtMs,
          now,
          draft,
        );
        break;
      case EntryKind.income:
        await _updateIncome(db, entryId, amountMinor, occurredAtMs, now, draft);
        break;
      case EntryKind.transfer:
        await _updateTransfer(
          db,
          entryId,
          amountMinor,
          occurredAtMs,
          now,
          draft,
        );
        break;
    }
  }

  /// 删除一条流水（默认软删：txns.is_deleted = true）
  Future<void> deleteEntry({
    required String ledgerId,
    required String entryId,
  }) async {
    final db = await DbManager.instance.ledger(ledgerId);
    final now = DateTime.now().millisecondsSinceEpoch;

    // 软删 txns
    await (db.update(
      db.txns,
    )..where((t) => t.txnId.equals(entryId) & t.isDeleted.equals(false))).write(
      TxnsCompanion(
        isDeleted: const drift.Value(true),
        updatedAtMs: drift.Value(now),
      ),
    );

    // 可选：同时软删附件（避免继续展示旧附件）
    await (db.update(
      db.txnAttachments,
    )..where((t) => t.txnId.equals(entryId) & t.isDeleted.equals(false))).write(
      TxnAttachmentsCompanion(
        isDeleted: const drift.Value(true),
        updatedAtMs: drift.Value(now),
      ),
    );
  }

  // ==========================================================
  // inserts
  // ==========================================================
  Future<void> _insertExpense(
    LedgerDb db,
    String txnId,
    int amountMinor,
    int occurredAtMs,
    int now,
    EntryDraft draft,
  ) async {
    final accountId = await _findAccountId(db, draft.account);
    final categoryId = await _findCategoryId(
      db,
      CategoryType.expense,
      draft.category,
    );

    await db
        .into(db.txns)
        .insert(
          TxnsCompanion.insert(
            txnId: txnId,
            txnType: TxnType.expense,
            occurredAtMs: occurredAtMs,
            amountMinor: amountMinor,
            createdAtMs: now,
            updatedAtMs: now,
            accountId: drift.Value(accountId),
            categoryId: drift.Value(categoryId),
            note: drift.Value(_noteOrNull(draft.remark)),
          ),
        );
  }

  Future<void> _insertIncome(
    LedgerDb db,
    String txnId,
    int amountMinor,
    int occurredAtMs,
    int now,
    EntryDraft draft,
  ) async {
    final accountId = await _findAccountId(db, draft.account);
    final categoryId = await _findCategoryId(
      db,
      CategoryType.income,
      draft.category,
    );

    await db
        .into(db.txns)
        .insert(
          TxnsCompanion.insert(
            txnId: txnId,
            txnType: TxnType.income,
            occurredAtMs: occurredAtMs,
            amountMinor: amountMinor,
            createdAtMs: now,
            updatedAtMs: now,
            accountId: drift.Value(accountId),
            categoryId: drift.Value(categoryId),
            note: drift.Value(_noteOrNull(draft.remark)),
          ),
        );
  }

  Future<void> _insertTransfer(
    LedgerDb db,
    String txnId,
    int amountMinor,
    int occurredAtMs,
    int now,
    EntryDraft draft,
  ) async {
    final fromId = await _findAccountId(db, draft.fromAccount);
    final toId = await _findAccountId(db, draft.toAccount);

    if (fromId == null || toId == null) {
      throw ArgumentError('转账账户不存在（请先初始化账户或修正名称映射）');
    }
    if (fromId == toId) {
      throw ArgumentError('转出与转入账户不能相同');
    }

    await db
        .into(db.txns)
        .insert(
          TxnsCompanion.insert(
            txnId: txnId,
            txnType: TxnType.transfer,
            occurredAtMs: occurredAtMs,
            amountMinor: amountMinor,
            createdAtMs: now,
            updatedAtMs: now,
            fromAccountId: drift.Value(fromId),
            toAccountId: drift.Value(toId),
            note: drift.Value(_noteOrNull(draft.remark)),
          ),
        );
  }

  // ==========================================================
  // updates
  // ==========================================================
  Future<void> _updateExpense(
    LedgerDb db,
    String txnId,
    int amountMinor,
    int occurredAtMs,
    int now,
    EntryDraft draft,
  ) async {
    final accountId = await _findAccountId(db, draft.account);
    final categoryId = await _findCategoryId(
      db,
      CategoryType.expense,
      draft.category,
    );

    await (db.update(
      db.txns,
    )..where((t) => t.isDeleted.equals(false) & t.txnId.equals(txnId))).write(
      TxnsCompanion(
        txnType: const drift.Value(TxnType.expense),
        occurredAtMs: drift.Value(occurredAtMs),
        amountMinor: drift.Value(amountMinor),
        updatedAtMs: drift.Value(now),
        accountId: drift.Value(accountId),
        categoryId: drift.Value(categoryId),
        // expense/income 场景：清掉 transfer 字段，避免脏数据
        fromAccountId: const drift.Value<String?>(null),
        toAccountId: const drift.Value<String?>(null),
        note: drift.Value(_noteOrNull(draft.remark)),
        isDeleted: const drift.Value(false),
      ),
    );
  }

  Future<void> _updateIncome(
    LedgerDb db,
    String txnId,
    int amountMinor,
    int occurredAtMs,
    int now,
    EntryDraft draft,
  ) async {
    final accountId = await _findAccountId(db, draft.account);
    final categoryId = await _findCategoryId(
      db,
      CategoryType.income,
      draft.category,
    );

    await (db.update(
      db.txns,
    )..where((t) => t.isDeleted.equals(false) & t.txnId.equals(txnId))).write(
      TxnsCompanion(
        txnType: const drift.Value(TxnType.income),
        occurredAtMs: drift.Value(occurredAtMs),
        amountMinor: drift.Value(amountMinor),
        updatedAtMs: drift.Value(now),
        accountId: drift.Value(accountId),
        categoryId: drift.Value(categoryId),
        fromAccountId: const drift.Value<String?>(null),
        toAccountId: const drift.Value<String?>(null),
        note: drift.Value(_noteOrNull(draft.remark)),
        isDeleted: const drift.Value(false),
      ),
    );
  }

  Future<void> _updateTransfer(
    LedgerDb db,
    String txnId,
    int amountMinor,
    int occurredAtMs,
    int now,
    EntryDraft draft,
  ) async {
    final fromId = await _findAccountId(db, draft.fromAccount);
    final toId = await _findAccountId(db, draft.toAccount);

    if (fromId == null || toId == null) {
      throw ArgumentError('转账账户不存在（请先初始化账户或修正名称映射）');
    }
    if (fromId == toId) {
      throw ArgumentError('转出与转入账户不能相同');
    }

    await (db.update(
      db.txns,
    )..where((t) => t.isDeleted.equals(false) & t.txnId.equals(txnId))).write(
      TxnsCompanion(
        txnType: const drift.Value(TxnType.transfer),
        occurredAtMs: drift.Value(occurredAtMs),
        amountMinor: drift.Value(amountMinor),
        updatedAtMs: drift.Value(now),
        fromAccountId: drift.Value(fromId),
        toAccountId: drift.Value(toId),
        // transfer 场景：清掉 expense/income 字段，避免脏数据
        accountId: const drift.Value<String?>(null),
        categoryId: const drift.Value<String?>(null),
        note: drift.Value(_noteOrNull(draft.remark)),
        isDeleted: const drift.Value(false),
      ),
    );
  }

  // ==========================================================
  // lookups (你原有 + 新增 name/path 反查)
  // ==========================================================
  Future<String?> _findAccountId(LedgerDb db, String displayName) async {
    final name = MoneyParser.normalizeAccountName(displayName);
    final rows =
        await (db.select(db.accounts)
              ..where((t) => t.isDeleted.equals(false) & t.name.equals(name))
              ..limit(1))
            .get();
    return rows.isEmpty ? null : rows.first.accountId;
  }

  Future<String?> _findAccountName(LedgerDb db, String? accountId) async {
    if (accountId == null || accountId.isEmpty) return null;
    final rows =
        await (db.select(db.accounts)
              ..where(
                (t) =>
                    t.isDeleted.equals(false) & t.accountId.equals(accountId),
              )
              ..limit(1))
            .get();
    return rows.isEmpty ? null : rows.first.name;
  }

  Future<String?> _findCategoryId(
    LedgerDb db,
    CategoryType type,
    String pathText,
  ) async {
    final parts = MoneyParser.splitCategoryPath(pathText);
    if (parts.isEmpty) return null;

    // 1级
    final parentName = parts[0];
    final parentRows =
        await (db.select(db.categories)
              ..where(
                (t) =>
                    t.isDeleted.equals(false) &
                    t.type.equals(type.name) &
                    t.parentId.isNull() &
                    t.name.equals(parentName),
              )
              ..limit(1))
            .get();

    if (parentRows.isEmpty) {
      // 允许直接按名称命中
      return await _findCategoryByName(db, type, parentName);
    }
    final parent = parentRows.first;

    // 只有一级
    if (parts.length == 1) return parent.categoryId;

    // 2级
    final childName = parts[1];
    final childRows =
        await (db.select(db.categories)
              ..where(
                (t) =>
                    t.isDeleted.equals(false) &
                    t.type.equals(type.name) &
                    t.parentId.equals(parent.categoryId) &
                    t.name.equals(childName),
              )
              ..limit(1))
            .get();

    return childRows.isEmpty ? parent.categoryId : childRows.first.categoryId;
  }

  Future<String?> _findCategoryByName(
    LedgerDb db,
    CategoryType type,
    String name,
  ) async {
    final rows =
        await (db.select(db.categories)
              ..where(
                (t) =>
                    t.isDeleted.equals(false) &
                    t.type.equals(type.name) &
                    t.name.equals(name),
              )
              ..limit(1))
            .get();
    return rows.isEmpty ? null : rows.first.categoryId;
  }

  /// categoryId -> "父/子" 或 "单级"
  Future<String?> _findCategoryPath(LedgerDb db, String? categoryId) async {
    if (categoryId == null || categoryId.isEmpty) return null;

    final rows =
        await (db.select(db.categories)
              ..where(
                (t) =>
                    t.isDeleted.equals(false) & t.categoryId.equals(categoryId),
              )
              ..limit(1))
            .get();
    if (rows.isEmpty) return null;

    final c = rows.first;
    if (c.parentId == null || c.parentId!.isEmpty) {
      return c.name;
    }

    final parentRows =
        await (db.select(db.categories)
              ..where(
                (t) =>
                    t.isDeleted.equals(false) &
                    t.categoryId.equals(c.parentId!),
              )
              ..limit(1))
            .get();
    if (parentRows.isEmpty) return c.name;

    // 用 "/" 拼接，与你的 MoneyParser.splitCategoryPath 常见实现兼容
    return '${parentRows.first.name}/${c.name}';
  }

  // ==========================================================
  // helpers
  // ==========================================================
  EntryKind _entryKindFromTxnType(TxnType t) {
    switch (t) {
      case TxnType.expense:
        return EntryKind.expense;
      case TxnType.income:
        return EntryKind.income;
      case TxnType.transfer:
        return EntryKind.transfer;
    }
  }

  String? _noteOrNull(String s) {
    final v = s.trim();
    return v.isEmpty ? null : v;
  }

  /// draft.amount 期望是 "12.34"
  String _minorToAmountText(int minor) {
    return (minor / 100.0).toStringAsFixed(2);
  }

  /// draft.timeText 至少要包含 "MM月DD日"，你的 _parseOccurredAtMs 用这个正则提取
  String _occurredAtToTimeText(int occurredAtMs) {
    final dt = DateTime.fromMillisecondsSinceEpoch(occurredAtMs);
    final mm = dt.month.toString().padLeft(2, '0');
    final dd = dt.day.toString().padLeft(2, '0');
    return '${mm}月${dd}日';
  }

  int _parseOccurredAtMs(String timeText) {
    final now = DateTime.now();
    final reg = RegExp(r'(\d{2})月(\d{2})日');
    final m = reg.firstMatch(timeText);
    if (m == null) return now.millisecondsSinceEpoch;

    final month = int.tryParse(m.group(1)!) ?? now.month;
    final day = int.tryParse(m.group(2)!) ?? now.day;

    // 当前 UI 没有“具体时分”，先沿用当前时分
    final dt = DateTime(now.year, month, day, now.hour, now.minute);
    return dt.millisecondsSinceEpoch;
  }
}
