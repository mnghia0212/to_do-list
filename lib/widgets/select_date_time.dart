import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/widgets.dart';

class SelectDateTime extends ConsumerStatefulWidget {
  final Tasks? task;
  const SelectDateTime({Key? key, this.task}) : super(key: key);


  @override
  ConsumerState<SelectDateTime> createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends ConsumerState<SelectDateTime> {
  @override
  void initState() {
    super.initState();
    if (widget.task == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(dateProvider.notifier).state = null;
        ref.read(timeProvider.notifier).state = null;
      });
    } 
  }

  @override
  Widget build(BuildContext context) {
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    String hintTextDate = _hintTextDate(date, widget.task);
    String hintTextTime = _hintTextTime(time, widget.task);

    return Row(
      children: [
        Expanded(
            child: CommonTextfield(
          labelName: "Date:",
          hintText: hintTextDate,
          suffixIcon: IconButton(
              onPressed: () => selectDate(context, ref, widget.task),
              icon: const FaIcon(FontAwesomeIcons.calendar)),
          readOnly: true,
        )),
        const Gap(15),
        Expanded(
            child: CommonTextfield(
          labelName: "Time:",
          hintText: hintTextTime,
          suffixIcon: IconButton(
              onPressed: () => selectTime(context, ref, widget.task),
              icon: const FaIcon(FontAwesomeIcons.clock)),
          readOnly: true,
        ))
      ],
    );
  }

  String _hintTextDate(DateTime? date, Tasks? task) {
    if (date != null) {
      return DateFormat.yMMMd().format(date);
    } else if (task != null) {
      return task.date ?? "No date";
    } else {
      return "Select date";
    }
  }

  String _hintTextTime(TimeOfDay? time, Tasks? task) {
    if (time != null) {
      return Helpers.timeToString(time);
    } else if (task != null) {
      return task.time ?? "No time";
    } else {
      ref.read(timeProvider.notifier).state = null;
      return "Select time";
    }
  }

  void selectTime(BuildContext context, WidgetRef ref, Tasks? task) async {
    final format = DateFormat.jm();
    final initialTime = task == null
        ? ref.read(timeProvider) ?? TimeOfDay.now()
        : TimeOfDay.fromDateTime(
            format.parse(task.time ?? Helpers.timeToString(TimeOfDay.now())));

    TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: initialTime);

    if (pickedTime != null) {
      ref.read(timeProvider.notifier).state = pickedTime;
    }
  }

  void selectDate(BuildContext context, WidgetRef ref, Tasks? task) async {
    final initialDate = task == null
        ? ref.read(dateProvider) ?? DateTime.now()
        : DateFormat.yMMMd()
            .parse(task.date ?? Helpers.dateFormatter(DateTime.now()));

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2084));
    if (pickedDate != null) {
      ref.read(dateProvider.notifier).state = pickedDate;
    }
   
  }
}
