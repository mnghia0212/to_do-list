import 'package:flutter/material.dart';
import 'package:todo_app/utils/extensions.dart';

class DisplayText extends StatelessWidget {
  const DisplayText(
      {super.key, required this.text, this.fontSize, this.fontWeight, this.color = Colors.white});

  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
          //color: color,
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.bold),
    );
  }
}
