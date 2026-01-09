// lib/flow/data/flow_repository.dart
import 'package:drift/drift.dart';

import '../../data/db/db_manager.dart';
import '../../data/db/ledger/ledger_db.dart';
import '../../data/db/ledger/ledger_tables.dart';
import 'flow_vm.dart' as vm;

class FlowRepository {
  final LedgerDb _db;

  FlowRepository._(this._db);

  static Future<FlowRepository> open(String ledgerId) async {
    final db = await DbManager.instance.ledger(ledgerId);
    return FlowRepository._(db);
  }

  Stream<List<vm.FlowTxnVM>> watchTxns({
    String? accountId,
    String? itemId,
    int limit = 800,
    int? fromMs,
    int? toMs,
    bool onlyPosted = true,
  }) {
    final txns = _db.txns;
    final cats = _db.categories;
    final parentCats = _db.categories.createAlias('parent_cats');

    // 二级分类 icon（cats.iconId -> iconResources）
    final catIcon = _db.iconResources.createAlias('cat_icon');

    final acc = _db.accounts;
    final fromAcc = _db.accounts.createAlias('from_acc');
    final toAcc = _db.accounts.createAlias('to_acc');
    final feeAcc = _db.accounts.createAlias('fee_acc');

    final items = _db.items;
    final parties = _db.parties;

    final joinQ = _db.select(txns).join([
      leftOuterJoin(cats, cats.categoryId.equalsExp(txns.categoryId)),
      leftOuterJoin(parentCats, parentCats.categoryId.equalsExp(cats.parentId)),
      leftOuterJoin(catIcon, catIcon.iconId.equalsExp(cats.iconId)),

      leftOuterJoin(acc, acc.accountId.equalsExp(txns.accountId)),
      leftOuterJoin(fromAcc, fromAcc.accountId.equalsExp(txns.fromAccountId)),
      leftOuterJoin(toAcc, toAcc.accountId.equalsExp(txns.toAccountId)),
      leftOuterJoin(feeAcc, feeAcc.accountId.equalsExp(txns.feeAccountId)),

      leftOuterJoin(items, items.itemId.equalsExp(txns.itemId)),
      leftOuterJoin(parties, parties.partyId.equalsExp(txns.partyId)),
    ]);

    joinQ.where(txns.isDeleted.equals(false));

    if (onlyPosted) {
      joinQ.where(txns.status.equals(TxnStatus.posted.name));
    }

    if (itemId != null && itemId.isNotEmpty) {
      joinQ.where(txns.itemId.equals(itemId));
    }

    if (fromMs != null) {
      joinQ.where(txns.occurredAtMs.isBiggerOrEqualValue(fromMs));
    }
    if (toMs != null) {
      joinQ.where(txns.occurredAtMs.isSmallerThanValue(toMs));
    }

    final hasAccount = accountId != null && accountId.isNotEmpty;
    if (hasAccount) {
      final a = txns.accountId.equals(accountId!);
      final b = txns.fromAccountId.equals(accountId);
      final c = txns.toAccountId.equals(accountId);
      final d = txns.feeAccountId.equals(accountId);
      joinQ.where(a | b | c | d);
    }

    joinQ.orderBy([
      OrderingTerm.desc(txns.occurredAtMs),
      OrderingTerm.desc(txns.createdAtMs),
    ]);
    joinQ.limit(limit);

    return joinQ.watch().map((rows) {
      return rows
          .map<vm.FlowTxnVM>((r) {
            final t = r.readTable(txns);

            final c = r.readTableOrNull(cats);
            final pc = r.readTableOrNull(parentCats);
            final ic = r.readTableOrNull(catIcon);

            final a = r.readTableOrNull(acc);
            final fa = r.readTableOrNull(fromAcc);
            final ta = r.readTableOrNull(toAcc);
            final fea = r.readTableOrNull(feeAcc);

            final it = r.readTableOrNull(items);
            final p = r.readTableOrNull(parties);

            final signed = _signedAmount(
              txnType: t.txnType,
              amountMinor: t.amountMinor,
              fromAccountId: t.fromAccountId,
              toAccountId: t.toAccountId,
              feeAccountId: t.feeAccountId,
              feeAmountMinor: t.feeAmountMinor,
              filterAccountId: hasAccount ? accountId : null,
            );

            final title = _buildTitle(
              txnType: t.txnType,
              categoryName: c?.name,
            );

            final subTitle = _buildSubTitle(
              occurredAtMs: t.occurredAtMs,
              txnType: t.txnType,
              accountName: a?.name,
              fromAccountName: fa?.name,
              toAccountName: ta?.name,
              partyPhone: p?.phone,
              itemName: it?.name,
            );

            return vm.FlowTxnVM(
              txnId: t.txnId,
              txnType: t.txnType,
              occurredAtMs: t.occurredAtMs,
              amountMinor: t.amountMinor,
              signedAmountMinor: signed,
              title: title,
              subTitle: subTitle,

              categoryId: c?.categoryId,
              categoryName: c?.name,
              parentCategoryId: pc?.categoryId,
              parentCategoryName: pc?.name,

              // 二级分类图标（流水行用它）
              categoryIconSource: ic?.source,
              categoryIconCodepoint: ic?.codepoint,
              categoryIconFontFamily: ic?.fontFamily,
              categoryIconAssetPath: ic?.assetPath,
              categoryIconFgColor: ic?.fgColor,
              categoryIconBgColor: ic?.bgColor,

              accountId: t.accountId,
              accountName: a?.name,

              fromAccountId: t.fromAccountId,
              fromAccountName: fa?.name,

              toAccountId: t.toAccountId,
              toAccountName: ta?.name,

              feeAccountId: t.feeAccountId,
              feeAccountName: fea?.name,

              itemId: t.itemId,
              itemName: it?.name,

              partyId: t.partyId,
              partyName: p?.name,
              partyPhone: p?.phone,

              note: t.note,
            );
          })
          .toList(growable: false);
    });
  }

  Stream<List<vm.FlowOption>> watchAccounts() {
    final q = _db.select(_db.accounts)
      ..where((t) => t.isDeleted.equals(false) & t.isArchived.equals(false))
      ..orderBy([
        (t) => OrderingTerm.asc(t.sortOrder),
        (t) => OrderingTerm.asc(t.createdAtMs),
      ]);

    return q.watch().map((rows) {
      return rows
          .map((a) => vm.FlowOption(a.accountId, a.name))
          .toList(growable: false);
    });
  }

  Stream<List<vm.FlowOption>> watchItems() {
    final q = _db.select(_db.items)
      ..where((t) => t.isDeleted.equals(false))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAtMs)]);

    return q.watch().map((rows) {
      return rows
          .map((it) => vm.FlowOption(it.itemId, it.name))
          .toList(growable: false);
    });
  }

  // ---------------- helpers ----------------

  static int _signedAmount({
    required TxnType txnType,
    required int amountMinor,
    required String? fromAccountId,
    required String? toAccountId,
    required String? feeAccountId,
    required int feeAmountMinor,
    required String? filterAccountId,
  }) {
    switch (txnType) {
      case TxnType.income:
        return amountMinor;
      case TxnType.expense:
        return -amountMinor;
      case TxnType.transfer:
        if (filterAccountId == null || filterAccountId.isEmpty) return 0;

        var s = 0;
        if (fromAccountId == filterAccountId) s -= amountMinor;
        if (toAccountId == filterAccountId) s += amountMinor;

        if (feeAccountId == filterAccountId && feeAmountMinor != 0) {
          s -= feeAmountMinor;
        }
        return s;
    }
  }

  static String _buildTitle({
    required TxnType txnType,
    required String? categoryName,
  }) {
    final cn = (categoryName ?? '').trim();
    if (cn.isNotEmpty) return cn;
    if (txnType == TxnType.transfer) return '转账';
    return '无分类';
  }

  static String _buildSubTitle({
    required int occurredAtMs,
    required TxnType txnType,
    required String? accountName,
    required String? fromAccountName,
    required String? toAccountName,
    required String? partyPhone,
    required String? itemName,
  }) {
    final segs = <String>[];

    if (txnType == TxnType.transfer) {
      final left = (fromAccountName ?? '').trim();
      final right = (toAccountName ?? '').trim();
      if (left.isNotEmpty || right.isNotEmpty) {
        segs.add(right.isEmpty ? left : '$left → $right');
      }
    } else {
      final a = (accountName ?? '').trim();
      if (a.isNotEmpty) segs.add(a);
    }

    final phone = _maskPhone(partyPhone);
    if (phone != null) segs.add(phone);

    final it = (itemName ?? '').trim();
    if (it.isNotEmpty) segs.add(it);

    segs.add(_hhmm(occurredAtMs));
    return segs.join(' · ');
  }

  static String _hhmm(int ms) {
    final d = DateTime.fromMillisecondsSinceEpoch(ms);
    final hh = d.hour.toString().padLeft(2, '0');
    final mm = d.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  static String? _maskPhone(String? phone) {
    if (phone == null) return null;
    final p = phone.replaceAll(' ', '').trim();
    if (p.length < 7) return null;

    if (RegExp(r'^\d{11}$').hasMatch(p)) {
      return '${p.substring(0, 3)}****${p.substring(7)}';
    }

    final keepHead = p.length >= 8 ? 3 : 2;
    final keepTail = p.length >= 8 ? 4 : 2;
    if (p.length <= keepHead + keepTail) return p;

    return '${p.substring(0, keepHead)}****${p.substring(p.length - keepTail)}';
  }
}
