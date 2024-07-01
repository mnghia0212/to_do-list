import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/utils/extensions.dart';

class CommonTextfield extends StatelessWidget {
  const CommonTextfield(
      {super.key,
      required this.labelName,
      required this.hintText,
      this.controller, 
      this.maxLines, 
      this.suffixIcon, 
      this.readOnly = false});

  final String labelName;
  final String hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          labelName,
          style: context.textTheme.titleLarge,
        ),
        const Gap(10),

        TextField(
          readOnly: readOnly,
          maxLines: maxLines,
          controller: controller,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon
          ),
        )
      ],
    );
  }
}
