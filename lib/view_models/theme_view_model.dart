import 'package:flutter/material.dart';
import 'package:thoughts/theme/app_theme.dart';

class ThemeViewModel extends ChangeNotifier {
  ThemeData _themeData = AppColors.theme;

  ThemeData get themeData => _themeData;

  void updateTheme(Color newPrimary) {
    AppColors.updateTheme(newPrimary);
    _themeData = AppColors.theme;
    notifyListeners();
  }
}