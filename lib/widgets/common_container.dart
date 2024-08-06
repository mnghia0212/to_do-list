import 'package:todo_app/utils/utils.dart';
import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer(
      {super.key, this.height, this.child, required this.backgroundColor});
  final double? height;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;

    return Container(
        width: deviceSize.width,
        height: height,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: child);
  }
}
