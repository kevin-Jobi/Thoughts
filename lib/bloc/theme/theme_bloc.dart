import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/theme/app_theme.dart';

abstract class ThemeEvent {}
class ChangePrimaryColor extends ThemeEvent {
  final Color color;
  ChangePrimaryColor(this.color);
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(AppColors.theme) {
    on<ChangePrimaryColor>((event, emit) {
      AppColors.updateTheme(event.color);
      emit(AppColors.theme);
    });
  }
}