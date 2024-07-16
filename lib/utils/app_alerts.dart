import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/utils/utils.dart';

class AppAlerts {
  static displaySnackBar(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        message,
        style: scaffoldMessengerKey.currentContext?.textTheme.bodyLarge?.copyWith(color: Colors.white),
      ),
      action: SnackBarAction(
        label: "Dismiss",
        onPressed: () {
          scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
        }
      ),
      duration: const Duration(
        seconds: 2,
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
            displaySnackBar('${task.title} deleted successfully');
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
