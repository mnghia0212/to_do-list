import 'package:flutter/material.dart';
import 'package:todo_app/utils/extensions.dart';

class DisplayTittleText extends StatelessWidget {
  const DisplayTittleText(
      {super.key, required this.text, this.fontSize, this.fontWeight, this.color = Colors.white});

  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      
      text,
      style: context.textTheme.bodyLarge?.copyWith(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.bold),
    );
  }
}
