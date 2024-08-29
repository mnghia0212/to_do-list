import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:todo_app/widgets/widgets.dart';

enum AlertType { success, warning, error, info }

class AppAlerts {
  static showFlushBar(BuildContext context, String message, AlertType type) {
    Color backgroundColor;
    IconData icon;
    String alertTitle;

    switch (type) {
      case AlertType.success:
        backgroundColor = Colors.greenAccent;
        icon = Icons.check_circle;
        alertTitle = "Success";
        break;

      case AlertType.warning:
        backgroundColor = Colors.yellowAccent;
        icon = Icons.warning;
        alertTitle = "Warning";
        break;

      case AlertType.error:
        backgroundColor = Colors.redAccent;
        icon = Icons.error;
        alertTitle = "Error";
        break;

      default:
        backgroundColor = Colors.orangeAccent;
        icon = Icons.info;
        alertTitle = "Info";
    }

    Flushbar(
      titleText: Text(alertTitle),
      titleColor: Colors.black,
      titleSize: 20,
      message: message,
      messageColor: Colors.black,
      messageSize: 17,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      isDismissible: true,
      duration: const Duration(seconds: 2),
      dismissDirection: FlushbarDismissDirection.VERTICAL,
      backgroundColor: backgroundColor,
      icon: Icon(
        icon,
        color: Colors.black,
      ),
      borderRadius: BorderRadius.circular(20),
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      boxShadows: const [
        BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 3.0)
      ],
    ).show(context);
  }

  static Future<bool> showAlertDeleteDialog({
    required BuildContext context,
    required WidgetRef ref,
    required Tasks task,
  }) async {
    Widget cancelButton = TextButton(
      child: const Text('NO'), 
      onPressed: () => context.pop(false)
    );

    Widget deleteButton = TextButton(
      onPressed: () => context.pop(true),
      child: const Text('YES'),
    );

    AlertDialog alert = AlertDialog(
      title: Text('Are you sure you want to delete ${task.title} permanently?'),
      actions: [
        deleteButton,
        cancelButton,
      ],
    );
    
    if(task.isDeleted){
      bool isDismiss = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        ) ??
        false;

      if (isDismiss) {
        await ref.read(taskProvider.notifier).removeTask(task).then((value) {
            AppAlerts.showFlushBar(
                context, '${task.title} deleted permanently', AlertType.success);
          });
      }
      
      return isDismiss;
    }
    return true;
  }
}
