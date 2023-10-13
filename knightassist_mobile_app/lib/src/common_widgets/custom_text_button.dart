import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';

// Custom text button with a fixed height
class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key, required this.text, this.style, this.onPressed});
  final String text;
  final TextStyle? style;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p48,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}