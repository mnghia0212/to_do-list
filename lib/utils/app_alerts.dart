import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppAlerts {
  AppAlerts._();

  static displaySnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        message,
        style: context.textTheme.bodyLarge?.copyWith(color: Colors.white),
      ),
      action: SnackBarAction(
        label: "Dismiss",
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      ),
      duration: const Duration(
        seconds: 1
      ),
    ));
  }

  static Future<void> showAlertDeleteDialog({
    required BuildContext context,
    required WidgetRef ref,
    required Tasks task,
  }) async {
    Widget cancelButton = TextButton(
      child: const Text('NO'),
      onPressed: () => context.pop(),
    );
    Widget deleteButton = TextButton(
      onPressed: () async {
        await ref.read(taskProvider.notifier).deleteTask(task).then(
          (value) {
            displaySnackBar(
              context,
              '${task.title} deleted successfully',
            );
            //to ignore the dialog
            context.pop();
          },
        );
      },
      child: const Text('YES'),
    );

    AlertDialog alert = AlertDialog(
      title: Text('Are you sure you want to delete ${task.title}?'),
      actions: [
        deleteButton,
        cancelButton,
      ],
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
