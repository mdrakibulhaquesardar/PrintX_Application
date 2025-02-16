import 'package:flutter/material.dart';

abstract class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final (String, Function(dynamic data))? submitForm;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.height = 50,
    this.submitForm,
  });

  @override
  Widget build(BuildContext context);

  // Helper method for common button structure
  Widget buildButtonChild(
    BuildContext context, {
    required Color textColor,
    required Color backgroundColor,
    BorderRadius? borderRadius,
    Border? border,
  }) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        border: border,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
