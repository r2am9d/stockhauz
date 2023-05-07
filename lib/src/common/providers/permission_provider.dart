import 'dart:io' show Platform;

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:permission_handler/permission_handler.dart' as perm_handler;

import 'package:stockhauz/src/db/daos/permission_dao.dart';
import 'package:stockhauz/src/common/models/permission_state.dart';

part 'permission_provider.g.dart';

@riverpod
class Permission extends _$Permission {
  @override
  PermissionStatus build() => PermissionStatus.denied;

  final List<perm_handler.Permission> _perms = <perm_handler.Permission>[
    perm_handler.Permission.storage,
    perm_handler.Permission.manageExternalStorage,
    perm_handler.Permission.camera,
    if (Platform.isIOS) perm_handler.Permission.photos,
    perm_handler.Permission.notification,
  ];

  void initialize() {
    PermissionDao.initializePermission();
  }

  Future<void> validate() async {
    final isGranted = await _isGranted(false);
    final permission = PermissionDao.getPermission();

    if (isGranted) {
      PermissionDao.savePermission(permission..isGranted = true);
      state = PermissionState.granted();
    } else {
      PermissionDao.savePermission(permission..isGranted = false);
      state = PermissionState.denied();
    }
  }

  Future<void> request() async {
    final isGranted = await _isGranted();
    final permission = PermissionDao.getPermission();

    if (isGranted) {
      PermissionDao.savePermission(permission..isGranted = true);
      state = PermissionState.granted();
    } else {
      PermissionDao.savePermission(permission..isGranted = false);
      state = PermissionState.denied();
    }
  }

  Future<bool> _isGranted([bool shouldRequest = true]) async {
    final permStatusList = <perm_handler.PermissionStatus>[];

    for (final perm in _perms) {
      final permStatus = await perm.status;
      if (!permStatus.isGranted) {
        if (shouldRequest) {
          final rs = await perm.request();

          if (!rs.isGranted) {
            permStatusList.add(rs);
          }
        } else {
          permStatusList.add(permStatus);
        }
      }
    }

    if (permStatusList.contains(perm_handler.PermissionStatus.denied) ||
        permStatusList.contains(perm_handler.PermissionStatus.restricted) ||
        permStatusList
            .contains(perm_handler.PermissionStatus.permanentlyDenied)) {
      return false;
    } else {
      return true;
    }
  }
}
