import 'package:dimy_teknologi_quiz/dimy_teknologi_quiz.dart';
import 'package:flutter/material.dart';

class LocaleSetting with ChangeNotifier {
  final String? defaultValue;

  LocaleSetting({
    this.defaultValue,
  });

  String get value =>
      preferences?.getString('locale_setting') ?? defaultValue ?? 'en';

  Future<void> setValue(String? value) async {
    if (value == null) {
      await preferences!.remove('locale_setting');
    } else {
      await preferences!.setString('locale_setting', value);
    }

    notifyListeners();
  }
}
