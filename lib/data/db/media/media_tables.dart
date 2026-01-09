import 'package:drift/drift.dart';

class MediaFiles extends Table {
  TextColumn get mediaId => text()(); // UUID
  TextColumn get ownerLedgerId => text().nullable()(); // 归属账本（可为空）
  TextColumn get localPath => text()(); // 相对路径建议：media/<ledgerId>/xxx.jpg
  TextColumn get thumbPath => text().nullable()();
  TextColumn get mimeType => text()();
  IntColumn get sizeBytes => integer().withDefault(const Constant(0))();
  IntColumn get width => integer().nullable()();
  IntColumn get height => integer().nullable()();
  TextColumn get sha256 => text().nullable()();
  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {mediaId};

  @override
  List<String> get customConstraints => ['UNIQUE(local_path)'];
}
