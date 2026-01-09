import 'package:collection/collection.dart';
import '../storage/app_paths.dart';
import 'meta/meta_db.dart';
import 'media/media_db.dart';
import 'ledger/ledger_db.dart';

class DbManager {
  DbManager._();
  static final DbManager instance = DbManager._();

  String _profileId = 'local';

  MetaDb? _meta;
  MediaDb? _media;
  final Map<String, LedgerDb> _ledgerCache = {};

  String get profileId => _profileId;

  Future<void> init({String profileId = 'local'}) async {
    _profileId = profileId;
    // 不强制立刻打开，按需懒加载
  }

  Future<void> switchProfile(String profileId) async {
    if (profileId == _profileId) return;
    await closeAll();
    _profileId = profileId;
  }

  Future<MetaDb> meta() async {
    if (_meta != null) return _meta!;
    final path = await AppPaths.metaDbPath(_profileId);
    _meta = MetaDb.open(path);
    return _meta!;
  }

  Future<MediaDb> media() async {
    if (_media != null) return _media!;
    final path = await AppPaths.mediaDbPath(_profileId);
    _media = MediaDb.open(path);
    return _media!;
  }

  Future<LedgerDb> ledger(String ledgerId) async {
    final cached = _ledgerCache[ledgerId];
    if (cached != null) return cached;

    final path = await AppPaths.ledgerDbPath(_profileId, ledgerId);
    final db = LedgerDb.open(path);
    _ledgerCache[ledgerId] = db;
    return db;
  }

  Future<void> closeLedger(String ledgerId) async {
    final db = _ledgerCache.remove(ledgerId);
    await db?.close();
  }

  Future<void> closeAll() async {
    for (final db in _ledgerCache.values.toList()) {
      await db.close();
    }
    _ledgerCache.clear();

    await _meta?.close();
    _meta = null;

    await _media?.close();
    _media = null;
  }
}
