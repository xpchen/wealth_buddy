import 'dart:math';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

import '../data/db/db_manager.dart';
import '../data/db/ledger/ledger_db.dart';
import '../data/db/ledger/ledger_tables.dart';
import 'account_type_ui.dart';

// IconResources.source 的存储值（与你项目的表定义保持一致：source 为 TEXT）。
const IconSource _kIconSourceMaterial = IconSource.material;

/// Account data access for Drift-based LedgerDb.
///
/// Data model notes (schema v2+):
/// - "隐藏" -> accounts.isArchived
/// - "计入统计" -> accounts.includeInTotals
/// - "排序" -> accounts.sortOrder (smaller comes first)
class AccountRepo {
  AccountRepo._();
  static final instance = AccountRepo._();

  /// Per-ledger db (lazy open via DbManager).
  Future<LedgerDb> _db(String ledgerId) => DbManager.instance.ledger(ledgerId);

  /// Watch active (non-deleted, non-archived) accounts for a ledger.
  Stream<List<Account>> watchActiveAccounts(String ledgerId) {
    return Stream.fromFuture(_db(ledgerId)).asyncExpand((db) {
      final q = db.select(db.accounts)
        ..where((t) => t.isDeleted.equals(false) & t.isArchived.equals(false))
        ..orderBy([
          (t) => drift.OrderingTerm.asc(t.sortOrder),
          (t) => drift.OrderingTerm.asc(t.createdAtMs),
        ]);
      return q.watch();
    });
  }

  Future<Account?> getById(String ledgerId, String accountId) async {
    final db = await _db(ledgerId);
    final q = db.select(db.accounts)
      ..where((t) => t.accountId.equals(accountId))
      ..limit(1);
    return q.getSingleOrNull();
  }

  // --------------------------
  // Create / Update
  // --------------------------

  Future<String> createAccount({
    required String ledgerId,
    required AccountType type,
    required String name,
    required int initialBalanceMinor,
    bool hidden = false,
    bool includeInTotals = true,
    int sortOrder = 0,
  }) async {
    final db = await _db(ledgerId);
    final now = DateTime.now().millisecondsSinceEpoch;

    final ui = accountTypeUi(type);
    final iconId = await _ensureMaterialIcon(db, ui.icon);

    final id = _genId();
    await db
        .into(db.accounts)
        .insert(
          AccountsCompanion.insert(
            accountId: id,
            name: name,
            accountType: type,
            currencyCode: const drift.Value('CNY'),
            iconId: drift.Value<String?>(iconId),
            initialBalanceMinor: drift.Value(initialBalanceMinor),
            initialBalanceAtMs: drift.Value(now),
            creditLimitMinor: const drift.Value<int?>(null),
            billingDay: const drift.Value<int?>(null),
            repaymentDay: const drift.Value<int?>(null),
            note: const drift.Value<String?>(null),
            includeInTotals: drift.Value<bool>(includeInTotals),
            sortOrder: drift.Value<int>(sortOrder),
            isArchived: drift.Value<bool>(hidden),
            createdAtMs: now,
            updatedAtMs: now,
            isDeleted: const drift.Value(false),
          ),
        );
    return id;
  }

  Future<void> updateAccount({
    required String ledgerId,
    required String accountId,
    required String name,
    required int initialBalanceMinor,
    required bool hidden,
    required bool includeInTotals,
    required int sortOrder,
  }) async {
    final db = await _db(ledgerId);
    final now = DateTime.now().millisecondsSinceEpoch;

    await (db.update(
      db.accounts,
    )..where((t) => t.accountId.equals(accountId))).write(
      AccountsCompanion(
        name: drift.Value(name),
        initialBalanceMinor: drift.Value(initialBalanceMinor),
        initialBalanceAtMs: drift.Value(now),
        includeInTotals: drift.Value<bool>(includeInTotals),
        sortOrder: drift.Value<int>(sortOrder),
        isArchived: drift.Value<bool>(hidden),
        updatedAtMs: drift.Value(now),
      ),
    );
  }

  // --------------------------
  // Icon resources
  // --------------------------

  Future<String> _ensureMaterialIcon(LedgerDb db, IconData icon) async {
    final font = icon.fontFamily ?? 'MaterialIcons';

    final existing =
        await (db.select(db.iconResources)
              ..where(
                (t) =>
                    t.source.equals(_kIconSourceMaterial.name) &
                    t.codepoint.equals(icon.codePoint) &
                    t.fontFamily.equals(font),
              )
              ..limit(1))
            .getSingleOrNull();

    if (existing != null) return existing.iconId;

    final now = DateTime.now().millisecondsSinceEpoch;
    final iconId = _genId();

    await db
        .into(db.iconResources)
        .insert(
          IconResourcesCompanion.insert(
            iconId: iconId,
            source: _kIconSourceMaterial,
            codepoint: drift.Value<int?>(icon.codePoint),
            fontFamily: drift.Value<String?>(font),
            assetPath: const drift.Value<String?>(null),
            mediaId: const drift.Value<String?>(null),
            fgColor: const drift.Value<String?>(null),
            bgColor: const drift.Value<String?>(null),
            createdAtMs: now,
            updatedAtMs: now,
            isDeleted: const drift.Value(false),
          ),
        );

    return iconId;
  }
}

/// 不依赖 uuid 的本地唯一 id（足够用于离线主键）
final _rnd = Random.secure();
String _genId() {
  final ts = DateTime.now().microsecondsSinceEpoch.toRadixString(16);
  final r1 = _rnd.nextInt(1 << 32).toRadixString(16).padLeft(8, '0');
  final r2 = _rnd.nextInt(1 << 32).toRadixString(16).padLeft(8, '0');
  return '$ts$r1$r2';
}
