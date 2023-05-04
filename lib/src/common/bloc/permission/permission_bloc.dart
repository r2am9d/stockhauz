import 'dart:io' show Platform;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:multi_state_bloc/multi_state_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:stockhauz/src/utils/log_util.dart';
import 'package:stockhauz/src/db/daos/permission_dao.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends MultiStateBloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(const PermissionInitial()) {
    on<PermissionInitialize>(_initialize, transformer: sequential());
    on<PermissionValidate>(_validate, transformer: sequential());
    on<PermissionRequest>(_request, transformer: sequential());

    holdState(() => const PermissionLoaded());
  }

  final perms = <Permission>[
    Permission.storage,
    Permission.manageExternalStorage,
    Permission.camera,
    if (Platform.isIOS) Permission.photos,
    Permission.notification,
  ];

  void _initialize(
    PermissionInitialize event,
    Emitter<PermissionState> emit,
  ) {
    PermissionDao.initializePermission();
  }

  Future<void> _validate(
    PermissionValidate event,
    Emitter<PermissionState> emit,
  ) async {
    final isGranted = await _isGranted(false);
    final permission = PermissionDao.getPermission();

    if (isGranted) {
      PermissionDao.savePermission(permission..status = true);
      emit(const PermissionLoaded(PermissionStatus.granted));
    } else {
      emit(const PermissionLoaded());
    }
  }

  Future<void> _request(
    PermissionRequest event,
    Emitter<PermissionState> emit,
  ) async {
    final isGranted = await _isGranted();
    final permission = PermissionDao.getPermission();

    if (isGranted) {
      PermissionDao.savePermission(permission..status = true);
      emit(const PermissionLoaded(PermissionStatus.granted));
    } else {
      emit(const PermissionLoaded());
    }
  }

  Future<bool> _isGranted([bool shouldRequest = true]) async {
    final permStatusList = <PermissionStatus>[];

    for (final perm in perms) {
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

    if (permStatusList.contains(PermissionStatus.denied) ||
        permStatusList.contains(PermissionStatus.restricted) ||
        permStatusList.contains(PermissionStatus.permanentlyDenied)) {
      return false;
    } else {
      return true;
    }
  }
}
