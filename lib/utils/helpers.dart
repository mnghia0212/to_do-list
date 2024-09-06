import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/date_provider.dart';
import 'package:todo_app/providers/providers.dart';

class Helpers {
  Helpers._(this.ref);
  final WidgetRef ref;

  static String timeToString(TimeOfDay time) {
    try {
      final DateTime now = DateTime.now();
      final date =
          DateTime(now.year, now.month, now.day, time.hour, time.minute);
      return DateFormat.jm().format(date);
    } catch (e) {
      return "12:00 pm";
    }
  }

  static DateTime _stringToDateTime(String? dateString) {
    try {
      DateFormat format = DateFormat.yMMMd();
      if (dateString != null) {
        return format.parse(dateString);
      }
      return DateTime.now();
    } catch (e) {
      return DateTime.now();
    }
  }

  static String dateFormatter(DateTime date) {
    try {
      return DateFormat.yMMMd().format(date);
    } catch (e) {
      return DateFormat.yMMMd().format(
        DateTime.now(),
      );
    }
  }

  static void selectDate(BuildContext context, WidgetRef ref) async {
    final initialDate = ref.read(dateProvider) ?? DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2060),
    );

    if (pickedDate != null) {
      ref.read(dateProvider.notifier).state = pickedDate;
    }
  }

  static bool isTaskFromSelectedDate(Tasks task, DateTime selectedDate) {
    final DateTime taskDate = _stringToDateTime(task.date);

    if (taskDate != DateTime.now() && taskDate.month == selectedDate.month &&
        taskDate.year == selectedDate.year &&
        taskDate.day == selectedDate.day) {
      return true;
    }
    return false;
  }

  static Tasks? getTaskById(String? id, WidgetRef ref) {
    if (id == null) return null;

    try {
      final taskId = int.tryParse(id);
      if (taskId == null) return null;

      return ref
          .watch(taskProvider)
          .tasks
          .firstWhere((task) => task.id == taskId);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
