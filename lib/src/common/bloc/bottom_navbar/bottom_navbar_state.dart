part of 'bottom_navbar_bloc.dart';

abstract class BottomNavbarState extends Equatable {
  const BottomNavbarState();

  @override
  List<Object> get props => [];
}

class BottomNavbarInitial extends BottomNavbarState {}

class BottomNavbarLoaded extends BottomNavbarState {
  const BottomNavbarLoaded([this.index = 0]);

  final int index;

  @override
  List<Object> get props => [index];
}
