import 'package:dimy_teknologi_quiz/dimy_teknologi_quiz.dart';
import 'package:flutter/material.dart';

class ThemeModeSetting with ChangeNotifier {
  ThemeModeSetting();

  Future<void> darkMode() {
    return setMode(ThemeMode.dark);
  }

  Future<void> lightMode() {
    return setMode(ThemeMode.light);
  }

  Future<void> system() {
    return setMode(ThemeMode.system);
  }

  ThemeMode get mode {
    final value = preferences!.getInt('theme_mode_setting');

    return ThemeMode.values[value ?? 0];
  }

  Future<void> setMode(ThemeMode mode) async {
    await preferences!.setInt('theme_mode_setting', mode.index);
    notifyListeners();
  }
}
