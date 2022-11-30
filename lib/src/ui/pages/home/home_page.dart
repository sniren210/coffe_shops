import 'package:dimy_teknologi_quiz/dimy_teknologi_quiz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeModeSetting = context.watch<ThemeModeSetting>();

    final localeRepository = context.watch<LocaleSetting>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: localeRepository.value,
              underline: Container(),
              items: [
                for (final language in AppLocalizations.supportedLocales
                    .map<String>((e) => e.languageCode)
                    .toList())
                  DropdownMenuItem(
                    value: language,
                    child: Image.network(
                      'https://flagcdn.com/96x72/${getLanguageFlagCode(language).toLowerCase()}.png',
                      height: 18,
                      width: 24,
                      // kEmptyImageLink,
                    ),
                  ),
              ],
              onChanged: (value) {
                localeRepository.setValue(value ?? 'en');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: context.isDarkTheme
                  ? const Icon(
                      Icons.dark_mode,
                    )
                  : const Icon(
                      Icons.light_mode,
                    ),
              onPressed: () {
                context.isDarkTheme
                    ? themeModeSetting.lightMode()
                    : themeModeSetting.darkMode();
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              context.l10n.kTextCountTitle,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: context.l10n.kIncrement,
        child: const Icon(Icons.add),
      ),
    );
  }
}
