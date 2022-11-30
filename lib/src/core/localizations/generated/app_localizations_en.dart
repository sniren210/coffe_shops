import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get kLogin => 'Login';

  @override
  String get kLoginPIN => 'Login PIN';

  @override
  String get kRequiredPIN => 'PIN Required';

  @override
  String get kDigitPIN => 'PIN must be 4 Digits!';

  @override
  String get kNumberPIN => 'Please enter a number';

  @override
  String get kUserNotFound => 'User not registered';

  @override
  String get kHome => 'Home';

  @override
  String get kWelcome => 'Welcome';

  @override
  String get kCoffee => 'Coffee';

  @override
  String get kShowMore => 'Show More';

  @override
  String get kShowLess => 'Show Less';
}
