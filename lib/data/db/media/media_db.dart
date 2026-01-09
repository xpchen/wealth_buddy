import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'media_tables.dart';

part 'media_db.g.dart';

@DriftDatabase(tables: [MediaFiles])
class MediaDb extends _$MediaDb {
  MediaDb._(super.e);

  factory MediaDb.open(String path) {
    final executor = LazyDatabase(() async {
      final file = File(path);
      return NativeDatabase.createInBackground(file);
    });
    return MediaDb._(executor);
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
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_media_owner_ledger ON media_files(owner_ledger_id, created_at_ms);',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_media_deleted ON media_files(is_deleted);',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_media_sha256 ON media_files(sha256);',
      );
    },
  );
}
