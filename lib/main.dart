import 'package:dimy_teknologi_quiz/dimy_teknologi_quiz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  preferences = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocaleSetting(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeModeSetting(),
        ),
        ChangeNotifierProvider(
          create: (context) => CoffeeRepository(),
        )
      ],
      builder: (context, state) {
        final localeName = context.watch<LocaleSetting>().value;
        final themeMode = context.watch<ThemeModeSetting>().mode;

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Coffee Apps',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          locale: Locale(localeName),
          routerConfig: router,
        );
      },
    );
  }
}
