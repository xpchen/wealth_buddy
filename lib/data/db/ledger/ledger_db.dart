import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'ledger_tables.dart';

part 'ledger_db.g.dart';

@DriftDatabase(
  tables: [
    LedgerInfo,
    IconResources,
    Categories,
    Accounts,
    Parties,
    Items,
    Txns,
    TxnAttachments,
    BudgetPlans,
  ],
)
class LedgerDb extends _$LedgerDb {
  LedgerDb._(super.e);

  factory LedgerDb.open(String path) {
    final executor = LazyDatabase(() async {
      final file = File(path);
      return NativeDatabase.createInBackground(file);
    });
    return LedgerDb._(executor);
  }

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
    },
    onCreate: (m) async {
      await m.createAll();

      // 交易常用索引
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_txn_time ON txns(occurred_at_ms DESC);',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_txn_type_time ON txns(txn_type, occurred_at_ms DESC);',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_txn_account_time ON txns(account_id, occurred_at_ms DESC);',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_txn_category_time ON txns(category_id, occurred_at_ms DESC);',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_txn_party_time ON txns(party_id, occurred_at_ms DESC);',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_txn_deleted ON txns(is_deleted, occurred_at_ms DESC);',
      );

      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_attach_txn ON txn_attachments(txn_id, sort_order);',
      );

      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_category_type_sort ON categories(type, sort_order);',
      );

      // v2: 账户索引（可选，但建议加）
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_account_active ON accounts(is_deleted, is_archived, include_in_totals);',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_account_type_sort ON accounts(account_type, sort_order);',
      );

      // 预算相关索引
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_budget_month_scope ON budget_plans(month, scope_type, is_deleted);',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_budget_scope_id ON budget_plans(scope_type, scope_id, month);',
      );
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        // 1) 增加新列
        await m.addColumn(accounts, accounts.includeInTotals);
        await m.addColumn(accounts, accounts.sortOrder);

        // 2) 兜底回填（更稳，避免历史行出现 NULL）
        await customStatement(
          'UPDATE accounts SET include_in_totals = 1 WHERE include_in_totals IS NULL;',
        );
        await customStatement(
          'UPDATE accounts SET sort_order = 0 WHERE sort_order IS NULL;',
        );

        // 3) 新索引（建议）
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_account_active ON accounts(is_deleted, is_archived, include_in_totals);',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_account_type_sort ON accounts(account_type, sort_order);',
        );
      }
    },
  );
}
