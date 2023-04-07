import 'dart:io' show Platform;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:multi_state_bloc/multi_state_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends MultiStateBloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(const PermissionInitial()) {
    on<PermissionRequest>(_request, transformer: sequential());
    on<PermissionValidate>(_validate, transformer: sequential());

    holdState(() => const PermissionLoaded());
  }

  final perms = <Permission>[
    Permission.storage,
    Permission.manageExternalStorage,
    Permission.camera,
    if (Platform.isIOS) Permission.photos,
    Permission.notification,
  ];

  Future<void> _request(
    PermissionRequest event,
    Emitter<PermissionState> emit,
  ) async {
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
      emit(const PermissionLoaded(PermissionStatus.granted));
    }
  }

  Future<void> _validate(
    PermissionValidate event,
    Emitter<PermissionState> emit,
  ) async {
    final permissionLoadedState = states<PermissionLoaded>()!;
    if (permissionLoadedState.status == PermissionStatus.denied) {
      openAppSettings();
    }
  }
}
