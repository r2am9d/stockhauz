part of 'permission_bloc.dart';

@immutable
abstract class PermissionEvent extends Equatable {
  const PermissionEvent();

  @override
  List<Object> get props => [];
}

class PermissionInitialize extends PermissionEvent {
  const PermissionInitialize();
}

class PermissionValidate extends PermissionEvent {
  const PermissionValidate();
}

class PermissionRequest extends PermissionEvent {
  const PermissionRequest();
}
