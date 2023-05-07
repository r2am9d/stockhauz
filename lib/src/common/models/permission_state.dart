import 'package:freezed_annotation/freezed_annotation.dart';

part 'permission_state.g.dart';
part 'permission_state.freezed.dart';

enum PermissionStatus { denied, granted }

@freezed
class PermissionState with _$PermissionState {
  const factory PermissionState({
    @Default(PermissionStatus.denied) PermissionStatus status,
  }) = _PermissionState;

  factory PermissionState.fromJson(Map<String, Object?> json) =>
      _$PermissionStateFromJson(json);
  const PermissionState._();

  static PermissionStatus denied() =>
      const PermissionState(status: PermissionStatus.denied).status;
  static PermissionStatus granted() =>
      const PermissionState(status: PermissionStatus.granted).status;
}
