part of 'bottom_navbar_bloc.dart';

abstract class BottomNavbarEvent extends Equatable {
  const BottomNavbarEvent();

  @override
  List<Object?> get props => [];
}

class BottomNavbarShift extends BottomNavbarEvent {
  const BottomNavbarShift({required this.index});

  final int index;
}
