import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_navbar_provider.g.dart';

@riverpod
class BottomNavbar extends _$BottomNavbar {
  @override
  int build() => 0;

  void shift(int index) {
    state = index;
  }
}
