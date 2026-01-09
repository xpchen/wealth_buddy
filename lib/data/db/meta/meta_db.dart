import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'meta_tables.dart';

part 'meta_db.g.dart';

@DriftDatabase(tables: [MetaKv, WbLedgers, WbTemplates, WbLedgerRecents])
class MetaDb extends _$MetaDb {
  MetaDb._(super.e);

  factory MetaDb.open(String path) {
    final executor = LazyDatabase(() async {
      final file = File(path);
      return NativeDatabase.createInBackground(file);
    });
    return MetaDb._(executor);
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
    },
    onCreate: (m) async {
      await m.createAll();
      // 基础索引（可按需增删）
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_wb_ledger_updated ON wb_ledgers(updated_at_ms);',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_wb_ledger_deleted ON wb_ledgers(is_deleted);',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_recent_ledger_time ON wb_ledger_recents(ledger_id, opened_at_ms);',
      );
    },
    onUpgrade: (m, from, to) async {
      // 以后 schemaVersion 升级在这里做迁移
    },
  );
}
