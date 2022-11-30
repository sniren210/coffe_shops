import 'package:dimy_teknologi_quiz/dimy_teknologi_quiz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isGridView = false;

  @override
  Widget build(BuildContext context) {
    final themeModeSetting = context.watch<ThemeModeSetting>();

    final localeRepository = context.watch<LocaleSetting>();

    final repository = context.watch<CoffeeRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.kHome),
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
      body: RefreshIndicator(
        onRefresh: () async {
          await repository.fetch();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text('${context.l10n.kWelcome} 2022'),
                  TextButton(
                    onPressed: () async {
                      await preferences?.setBool('isLogin', false);
                      context.go('/pin');
                    },
                    child: Text(context.l10n.kLogout),
                  )
                ],
              ),
              HeaderCoffeeList(
                length: repository.isFetching ? 0 : repository.value.length,
                isGridView: _isGridView,
                onChanged: (isGridView) {
                  setState(() {
                    _isGridView = isGridView;
                  });
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              _isGridView
                  ? Expanded(
                      child: Coffee(
                        isGridView: true,
                      ),
                    )
                  : Expanded(
                      child: Coffee(
                        isGridView: false,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
