import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:multi_state_bloc/multi_state_bloc.dart';

part 'bottom_navbar_event.dart';
part 'bottom_navbar_state.dart';

class BottomNavbarBloc
    extends MultiStateBloc<BottomNavbarEvent, BottomNavbarState> {
  BottomNavbarBloc() : super(BottomNavbarInitial()) {
    on<BottomNavbarShift>(_shift, transformer: sequential());

    holdState(() => const BottomNavbarLoaded());
  }

  void _shift(
    BottomNavbarShift event,
    Emitter<BottomNavbarState> emit,
  ) {
    emit(BottomNavbarLoaded(event.index));
  }
}
