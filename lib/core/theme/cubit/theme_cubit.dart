import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stories_app/core/cache/preference_manager.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(PreferenceManager().isDarkMode() ? ThemeMode.dark : ThemeMode.light);

  void toggleTheme() {
    if (state == ThemeMode.dark) {
      emit(ThemeMode.light);
      PreferenceManager().saveIsDarkMode(false);
    } else {
      emit(ThemeMode.dark);
      PreferenceManager().saveIsDarkMode(true);
    }
  }
}
