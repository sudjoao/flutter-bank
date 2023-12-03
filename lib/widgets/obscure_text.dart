import 'package:flutter/material.dart';

class ObscureText extends StatelessWidget {
  const ObscureText(
    this.text, {
    super.key,
    required this.style,
    required this.obscureText,
  });
  final TextStyle style;
  final bool obscureText;
  final String text;

  String showText() {
    if (obscureText) {
      return '*' * text.length;
    } else {
      return text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      showText(),
      style: style,
      textAlign: TextAlign.center,
    );
  }
}
