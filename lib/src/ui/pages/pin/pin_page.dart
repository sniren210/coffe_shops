import 'package:dimy_teknologi_quiz/dimy_teknologi_quiz.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class PinPage extends StatefulWidget {
  const PinPage({super.key});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  late TextEditingController confirmPinController;
  StreamController<ErrorAnimationType>? errorController;

  @override
  void initState() {
    confirmPinController = TextEditingController();
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  _onKeyboardTap(String value) {
    if (confirmPinController.text.length < 4) {
      confirmPinController.text += value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeModeSetting = context.watch<ThemeModeSetting>();

    final localeRepository = context.watch<LocaleSetting>();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.kLogin),
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
      body: PhoneWidthWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _headerPinCode(),
            _keypad(),
          ],
        ),
      ),
    );
  }

  Widget _headerPinCode() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        Text(
          context.l10n.kLoginPIN,
          // style: AppTheme.headline1.white,
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: CustomPinCode(
            pinController: confirmPinController,
            errorController: errorController,
            onChanged: (value) {},
            onCompleted: (value) {},
          ),
        ),
      ],
    );
  }

  Widget _keypad() {
    return NumericKeyboard(
        onKeyboardTap: _onKeyboardTap,
        rightButtonFn: () {
          setState(() {
            if (confirmPinController.text.isNotEmpty) {
              confirmPinController.text = confirmPinController.text
                  .substring(0, confirmPinController.text.length - 1);
            }
          });
        },
        rightIcon: const Icon(
          Icons.backspace,
        ),
        leftButtonFn: () async {
          if (confirmPinController.text.isEmpty) {
            errorController!.add(ErrorAnimationType.shake);
            Helper.snackBar(
              context,
              message: context.l10n.kRequiredPIN,
              isFailure: true,
            );
            return;
          }

          if (confirmPinController.text.length < 4) {
            errorController!.add(ErrorAnimationType.shake);
            Helper.snackBar(
              context,
              message: context.l10n.kDigitPIN,
              isFailure: true,
            );
            return;
          }

          if (!RegExp(r'^[0-9]+$').hasMatch(confirmPinController.text)) {
            errorController!.add(ErrorAnimationType.shake);
            Helper.snackBar(
              context,
              message: context.l10n.kNumberPIN,
              isFailure: true,
            );
            return;
          }

          if (confirmPinController.text != '2022') {
            errorController!.add(ErrorAnimationType.shake);
            Helper.snackBar(
              context,
              message: context.l10n.kUserNotFound,
              isFailure: true,
            );
            return;
          }
          await preferences?.setBool('isLogin', true);

          // ignore: use_build_context_synchronously
          context.go('/');
        },
        leftIcon: const Icon(
          Icons.check,
        ),
        mainAxisAlignment: MainAxisAlignment.spaceBetween);
  }
}
