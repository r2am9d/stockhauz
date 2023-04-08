part of 'permission_bloc.dart';

@immutable
abstract class PermissionEvent extends Equatable {
  const PermissionEvent();

  @override
  List<Object?> get props => [];
}

class PermissionLoad extends PermissionEvent {
  const PermissionLoad();
}

class PermissionValidate extends PermissionEvent {
  const PermissionValidate();
}

class PermissionObserve extends PermissionEvent {
  const PermissionObserve();
}

class PermissionRequest extends PermissionEvent {
  const PermissionRequest();
}
