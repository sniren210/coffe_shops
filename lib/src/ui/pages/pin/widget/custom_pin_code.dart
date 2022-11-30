import 'dart:async';

import 'package:dimy_teknologi_quiz/dimy_teknologi_quiz.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCode extends StatelessWidget {
  final TextEditingController pinController;
  final StreamController<ErrorAnimationType>? errorController;
  final FocusNode? focusNode;
  final void Function(String)? onCompleted;
  final void Function(String) onChanged;
  final bool isDialog;
  final bool isObscure;
  final bool isAutoFocus;

  const CustomPinCode({
    Key? key,
    required this.pinController,
    this.errorController,
    this.onCompleted,
    required this.onChanged,
    this.focusNode,
    this.isDialog = false,
    this.isObscure = false,
    this.isAutoFocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle: isObscure
          ? context.theme.textTheme.headline4!.copyWith(color: Colors.pink)
          : context.theme.textTheme.headline4,
      length: 4,
      obscureText: isObscure,
      animationType: AnimationType.fade,
      showCursor: false,
      autoFocus: isAutoFocus,
      textStyle: isObscure
          ? context.theme.textTheme.headline4!.copyWith(color: Colors.pink)
          : context.theme.textTheme.headline4,
      animationDuration: Duration(milliseconds: 300),
      enableActiveFill: true,
      focusNode: focusNode,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.circle,
        activeColor: isDialog
            ? context.theme.colorScheme.primary
            : context.theme.colorScheme.secondary,
        activeFillColor: isDialog
            ? context.theme.colorScheme.primary
            : context.theme.colorScheme.secondary,
        inactiveColor: isDialog
            ? context.theme.colorScheme.secondary
            : context.theme.colorScheme.onSecondary,
        inactiveFillColor: isDialog
            ? context.theme.colorScheme.secondary
            : context.theme.colorScheme.onSecondary,
        selectedFillColor: isDialog
            ? context.theme.colorScheme.secondary
            : context.theme.colorScheme.onSecondary,
        selectedColor: isDialog
            ? context.theme.colorScheme.secondary
            : context.theme.colorScheme.onSecondary,
      ),
      controller: pinController,
      errorAnimationController: errorController,
      keyboardType: TextInputType.number,
      boxShadows: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
      onCompleted: onCompleted,
      onChanged: onChanged,
    );
  }
}
