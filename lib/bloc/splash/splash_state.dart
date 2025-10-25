part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashLoading extends SplashState {}

class SplashCompleted extends SplashState {
  final bool isAuthenticated;

  const SplashCompleted({required this.isAuthenticated});

  @override
  List<Object> get props => [isAuthenticated];
}