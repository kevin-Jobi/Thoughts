import 'package:flutter/material.dart';

// 1. App Colors (Dynamic – can be changed at runtime)
class AppColors {
  static Color primary = Color.fromARGB(255, 33, 40, 74);
  static Color primaryVariant = Colors.deepPurpleAccent;
  static Color background = Colors.white;
  static Color surface = Colors.white;
  static Color onPrimary = Colors.white;
  static Color onBackground = Colors.black87;
  static Color warning = Color(0xFFD32F2F);
  static Color warningLight =  Color(0xFFD32F2F);
  static Color success = Colors.green;

  // Method to update theme dynamically
  static void updateTheme(Color newPrimary) {
    primary = newPrimary;
    primaryVariant = newPrimary.withValues(alpha: .8);
    // Keep light theme feel – no dark mode
    background = Colors.white;
    surface = Colors.white;
    onPrimary = Colors.white;
    onBackground = Colors.black87;
  }

  static ThemeData get theme => ThemeData(
    colorScheme: ColorScheme.light(
      primary: primary,
      secondary: primaryVariant,
      background: background,
      surface: surface,
      onPrimary: onPrimary,
      onBackground: onBackground,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: background,
    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      foregroundColor: onPrimary,
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: onBackground),
      bodyMedium: TextStyle(color: onBackground.withValues(alpha: .8)),
    ),
  );
}





