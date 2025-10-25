import 'package:equatable/equatable.dart';

abstract class NavBarEvent extends Equatable {
  const NavBarEvent();

  @override
  List<Object> get props => [];
}

class NavItemSelected extends NavBarEvent {
  final int index;

  const NavItemSelected(this.index);

  @override
  List<Object> get props => [index];
}