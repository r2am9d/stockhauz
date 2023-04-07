part of 'permission_bloc.dart';

@immutable
abstract class PermissionState extends Equatable {
  const PermissionState();

  @override
  List<Object?> get props => [];
}

class PermissionInitial extends PermissionState {
  const PermissionInitial();
}

class PermissionLoaded extends PermissionState {
  const PermissionLoaded([
    this.status = PermissionStatus.denied,
  ]);

  final PermissionStatus status;

  @override
  List<Object?> get props => [status];
}
