import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// 所有“本地数据路径”的统一出口：
/// - profile 隔离（local / u_<uid>）
/// - db 路径
/// - media 路径
class AppPaths {
  AppPaths._();

  static const _appRootName = 'wealth_buddy';

  /// e.g. <AppSupportDir>/wealth_buddy/<profileId>/
  static Future<Directory> profileRootDir(String profileId) async {
    final support = await getApplicationSupportDirectory();
    final dir = Directory(p.join(support.path, _appRootName, profileId));
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  /// e.g. .../<profileId>/db/
  static Future<Directory> dbDir(String profileId) async {
    final root = await profileRootDir(profileId);
    final dir = Directory(p.join(root.path, 'db'));
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  /// e.g. .../<profileId>/db/meta.sqlite
  static Future<String> metaDbPath(String profileId) async {
    final dir = await dbDir(profileId);
    return p.join(dir.path, 'meta.sqlite');
  }

  /// e.g. .../<profileId>/db/media.sqlite
  static Future<String> mediaDbPath(String profileId) async {
    final dir = await dbDir(profileId);
    return p.join(dir.path, 'media.sqlite');
  }

  /// e.g. .../<profileId>/db/ledgers/ledger_<ledgerId>.sqlite
  static Future<String> ledgerDbPath(String profileId, String ledgerId) async {
    final dir = await dbDir(profileId);
    final ledgersDir = Directory(p.join(dir.path, 'ledgers'));
    if (!await ledgersDir.exists()) await ledgersDir.create(recursive: true);
    return p.join(ledgersDir.path, 'ledger_$ledgerId.sqlite');
  }

  /// e.g. .../<profileId>/media/<ledgerId>/
  static Future<Directory> ledgerMediaDir(
    String profileId,
    String ledgerId,
  ) async {
    final root = await profileRootDir(profileId);
    final dir = Directory(p.join(root.path, 'media', ledgerId));
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }
}
