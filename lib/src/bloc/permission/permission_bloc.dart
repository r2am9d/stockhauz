import 'dart:io' show Platform;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:multi_state_bloc/multi_state_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stockhauz/src/utils/db_util.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends MultiStateBloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(const PermissionInitial()) {
    on<PermissionLoad>(_load, transformer: sequential());
    on<PermissionValidate>(_validate, transformer: sequential());
    on<PermissionObserve>(_observe, transformer: sequential());

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

  void _load(PermissionLoad event, Emitter<PermissionState> emit) {
    DbUtil.loadPermission();
  }

  void _validate(PermissionValidate event, Emitter<PermissionState> emit) {
    final permission = DbUtil.getPermission();

    if (permission.status) {
      emit(const PermissionLoaded(PermissionStatus.granted));
    } else {
      emit(const PermissionLoaded());
    }
  }

  // TODO: Define implementation
  void _observe(PermissionObserve event, Emitter<PermissionState> emit) {}

  Future<void> _request(
    PermissionRequest event,
    Emitter<PermissionState> emit,
  ) async {
    final permission = DbUtil.getPermission();
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
      emit(const PermissionLoaded());
    } else {
      DbUtil.savePermission(permission..status = true);
      emit(const PermissionLoaded(PermissionStatus.granted));
    }
  }
}
