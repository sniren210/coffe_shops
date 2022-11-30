import 'package:flutter/material.dart';

extension ThemeContext on BuildContext {
  bool get isDarkTheme => theme.brightness == Brightness.dark;
  bool get isLightTheme => theme.brightness == Brightness.light;

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
}
