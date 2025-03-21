import 'package:flutter/material.dart';
import 'package:stories_app/core/cache/preference_manager.dart';
import 'package:stories_app/core/theme/widget_theme/text/text_theme.dart';

import 'app_colors.dart';

class AppThemes {
  static ThemeData light = ThemeData(
    iconTheme: const IconThemeData(color: Colors.black),
    primaryColor: AppColors.primaryColor,
    textTheme: TextThemes.light,
    scaffoldBackgroundColor: const Color(0xFFFEF7E5),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
    ),
  );

  static ThemeData dark = ThemeData(
    iconTheme: const IconThemeData(color: Colors.white),
    primaryColor: AppColors.primaryColor,
    textTheme: TextThemes.dark,
    scaffoldBackgroundColor: Color(0xff191201),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.black12,
    ),
  );


  static ThemeMode themeMode() {
    return PreferenceManager().isDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }
}
