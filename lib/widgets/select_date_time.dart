import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/widgets.dart';

class SelectDateTime extends ConsumerWidget {
  const SelectDateTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);

    return Row(
      children: [
        Expanded(
            child: CommonTextfield(
          labelName: "Date:",
          hintText: date != null 
            ? DateFormat.yMMMd().format(date)
            : "Select Date", // Hiển thị thông báo nếu date là null
          suffixIcon: IconButton(
              onPressed: () => selectDate(context, ref),
              icon: const FaIcon(FontAwesomeIcons.calendar)),
          readOnly: true,
        )),
        const Gap(15),
        Expanded(
            child: CommonTextfield(
          labelName: "Time:",
          hintText: Helpers.timeToString(time),
          suffixIcon: IconButton(
              onPressed: () => selectTime(context, ref),
              icon: const FaIcon(FontAwesomeIcons.clock)),
          readOnly: true,
        ))
      ],
    );
  }
}

void selectTime(BuildContext context, WidgetRef ref) async {
  final initialTime = ref.read(timeProvider);

  TimeOfDay? pickedTime = await showTimePicker(
      context: context, 
      initialTime: initialTime
  );

  if (pickedTime != null) {
    ref.read(timeProvider.notifier).state = pickedTime;
  }
}

void selectDate(BuildContext context, WidgetRef ref) async {
  final initialDate = ref.read(dateProvider) ?? DateTime.now(); // Sử dụng ngày hiện tại nếu null

  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2084));
  if (pickedDate != null) {
    ref.read(dateProvider.notifier).state = pickedDate;
  }
}
