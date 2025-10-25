import 'package:flutter_bloc/flutter_bloc.dart';
import 'nav_bar_event.dart';
import 'nav_bar_state.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  NavBarBloc() : super(const NavBarState(selectedIndex: 0)) {
    on<NavItemSelected>((event, emit) {
      emit(NavBarState(selectedIndex: event.index));
    });
  }
}