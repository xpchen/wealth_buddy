// lib/record_entry/domain/record_service.dart
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

  // -------------------------
  // inserts
  // -------------------------
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

  // -------------------------
  // lookups
  // -------------------------
  Future<String?> _findAccountId(LedgerDb db, String displayName) async {
    final name = MoneyParser.normalizeAccountName(displayName);
    final rows =
        await (db.select(db.accounts)
              ..where((t) => t.isDeleted.equals(false) & t.name.equals(name))
              ..limit(1))
            .get();
    return rows.isEmpty ? null : rows.first.accountId;
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
      // 如果收入类是“工资收入”这种不带父级路径，也允许直接命中子/父同名
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

  // -------------------------
  // helpers
  // -------------------------
  String? _noteOrNull(String s) {
    final v = s.trim();
    return v.isEmpty ? null : v;
  }

  int _parseOccurredAtMs(String timeText) {
    final now = DateTime.now();
    final reg = RegExp(r'(\d{2})月(\d{2})日');
    final m = reg.firstMatch(timeText);
    if (m == null) return now.millisecondsSinceEpoch;

    final month = int.tryParse(m.group(1)!) ?? now.month;
    final day = int.tryParse(m.group(2)!) ?? now.day;

    // 当前 UI 没有“具体时分”，先沿用当前时分，后续再升级为 DateTime 存储
    final dt = DateTime(now.year, month, day, now.hour, now.minute);
    return dt.millisecondsSinceEpoch;
  }
}
