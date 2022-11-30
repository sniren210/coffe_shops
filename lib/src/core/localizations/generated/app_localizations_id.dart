import 'app_localizations.dart';

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get kLogin => 'Masuk';

  @override
  String get kLogout => 'Keluar';

  @override
  String get kLoginPIN => 'Masuk PIN';

  @override
  String get kRequiredPIN => 'PIN Harus di isi';

  @override
  String get kDigitPIN => 'PIN harus 4 Digit!';

  @override
  String get kNumberPIN => 'Tolong masukan angka';

  @override
  String get kUserNotFound => 'User tidak terdaftar';

  @override
  String get kHome => 'Home';

  @override
  String get kWelcome => 'Selamat datang';

  @override
  String get kCoffee => 'Kopi';

  @override
  String get kShowMore => 'Lebih Banyak';

  @override
  String get kShowLess => 'Lebih Sedikit';
}
