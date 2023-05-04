import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stockhauz/src/db/models/permission.dart';

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

  static Isar get db => _db;

  static Future<void> initialize() async {
    _db = await openDatabase();
  }

  static Future<Isar> openDatabase() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return Isar.open(
        [PermissionSchema],
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  static Future<void> resetDatabase() async {
    await _db.writeTxn(() => _db.clear());
  }
}
