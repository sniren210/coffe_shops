import 'package:dimy_teknologi_quiz/dimy_teknologi_quiz.dart';
import 'package:flutter/material.dart';

class PhoneWidthWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final double? height;

  const PhoneWidthWidget({
    Key? key,
    required this.child,
    this.color,
    this.height,
    this.padding = const EdgeInsets.all(8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Center(
        child: Container(
          width: context.isDevicesPhone
              ? null
              : context.isDevicesTablet
                  ? context.appSize.width * 0.6
                  : context.appSize.width * 0.4,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
          child: child,
        ),
      ),
    );
  }
}
