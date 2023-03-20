import 'dart:io' show Platform;

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permStatusProvider =
    StateNotifierProvider<PermissionStatusNotifier, PermissionStatus>(
  (ref) => PermissionStatusNotifier(),
);

class PermissionStatusNotifier extends StateNotifier<PermissionStatus> {
  PermissionStatusNotifier() : super(PermissionStatus.denied) {
    perms = <Permission>[
      Permission.storage,
      Permission.manageExternalStorage,
      Permission.camera,
      if (Platform.isIOS) Permission.photos,
      Permission.notification,
    ];
  }

  late final List<Permission> perms;

  Future<void> requestPermission() async {
    final permStatusList = <PermissionStatus>[];
    for (final perm in perms) {
      final permStatus = await perm.status;
      if (!permStatus.isGranted) {
        await perm.shouldShowRequestRationale;
        final rs = await perm.request();
        await perm.shouldShowRequestRationale;

        if (!rs.isGranted) {
          permStatusList.add(rs);
        }
      }
    }

    if (permStatusList.contains(PermissionStatus.denied) ||
        permStatusList.contains(PermissionStatus.restricted) ||
        permStatusList.contains(PermissionStatus.permanentlyDenied)) {
      state = PermissionStatus.denied;
    } else {
      state = PermissionStatus.granted;
    }
  }

  Future<void> validatePermission() async {
    if (state == PermissionStatus.denied) {
      openAppSettings();
    }
  }
}
