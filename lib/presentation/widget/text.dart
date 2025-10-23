import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String message;
  final double fontSize;
  final String fontFamily;
  final Color color;

  const CustomText({
    super.key,
    required this.message,
    required this.fontSize,
    required this.fontFamily,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: color
      ),
    );
  }
}

TextStyle customTextStyle(double fontSize, String fontFamily) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
    fontFamily: fontFamily
  );
}