import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashLoading()) {
    on<StartSplash>((event, emit) async {
      await Future.delayed(const Duration(seconds: 3));
      // Check if user is authenticated
      final isAuthenticated = FirebaseAuth.instance.currentUser != null;
      emit(SplashCompleted(isAuthenticated: isAuthenticated));
    });

    add(StartSplash());
  }
}