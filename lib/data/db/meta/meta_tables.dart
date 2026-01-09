import 'package:drift/drift.dart';

class MetaKv extends Table {
  TextColumn get k => text()();
  TextColumn get v => text()();
  IntColumn get updatedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {k};
}

class WbLedgers extends Table {
  TextColumn get ledgerId => text()(); // UUID
  TextColumn get name => text()();
  TextColumn get templateCode => text()();
  TextColumn get currencyCode => text().withDefault(const Constant('CNY'))();
  TextColumn get timezone =>
      text().withDefault(const Constant('Asia/Shanghai'))();

  /// 例如：ledger_<ledgerId>.sqlite（建议存文件名或相对路径）
  TextColumn get dbFilename => text()();

  /// 可选：该账本的媒体目录相对路径
  TextColumn get dataDir => text().nullable()();

  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {ledgerId};
}

class WbTemplates extends Table {
  TextColumn get templateCode => text()(); // 'standard_v1'
  TextColumn get name => text()();
  IntColumn get version => integer().withDefault(const Constant(1))();
  BoolColumn get builtIn => boolean().withDefault(const Constant(true))();
  TextColumn get defJson => text()(); // JSON
  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {templateCode};
}

class WbLedgerRecents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get ledgerId => text()();
  IntColumn get openedAtMs => integer()();
}
