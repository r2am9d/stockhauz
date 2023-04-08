import 'package:isar/isar.dart';
import 'package:stockhauz/src/entities/permission.dart';

/// A customized database utility class.
///
/// Configuration:
/// {@tool snippet}
/// ```dart
/// main() async {
///   await DbUtil.initialize();
/// }
/// ```
/// {@end-tool}
class DbUtil {
  DbUtil._internal();

  static late final Isar _db;

  static Future<void> initialize() async {
    _db = await openDatabase();
  }

  static Future<Isar> openDatabase() async {
    if (Isar.instanceNames.isEmpty) {
      return Isar.open([
        PermissionSchema,
      ]);
    }

    return Future.value(Isar.getInstance());
  }

  static Future<void> resetDatabase() async {
    await _db.writeTxn(() => _db.clear());
  }

  // Permission Queries
  static void loadPermission() {
    if (_db.permissions.where().isEmptySync()) {
      final permission = Permission()..status = false;
      savePermission(permission);
    }
  }

  static void savePermission(Permission permission) {
    _db.writeTxnSync<int>(() => _db.permissions.putSync(permission));
  }

  static Permission getPermission() {
    return _db.permissions.where().findFirstSync()!;
  }

  static Stream<Permission?> observePermission() async* {
    final permission = getPermission();
    yield* _db.permissions.watchObject(
      permission.id,
      fireImmediately: true,
    );
  }
}
