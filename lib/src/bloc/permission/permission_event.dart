part of 'permission_bloc.dart';

@immutable
abstract class PermissionEvent extends Equatable {
  const PermissionEvent();

  @override
  List<Object?> get props => [];
}

class PermissionRequest extends PermissionEvent {
  const PermissionRequest();
}

class PermissionValidate extends PermissionEvent {
  const PermissionValidate();
}
