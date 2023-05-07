import 'package:isar/isar.dart';

import 'package:stockhauz/src/utils/db_util.dart';
import 'package:stockhauz/src/db/models/permission.dart';

class PermissionDao {
  PermissionDao._internal();

  static void initializePermission() {
    if (DbUtil.db.permissions.where().isEmptySync()) {
      final permission = Permission()..isGranted = false;
      savePermission(permission);
    }
  }

  static void savePermission(Permission permission) {
    DbUtil.db
        .writeTxnSync<int>(() => DbUtil.db.permissions.putSync(permission));
  }

  static Permission getPermission() {
    return DbUtil.db.permissions.where().findFirstSync()!;
  }
}
