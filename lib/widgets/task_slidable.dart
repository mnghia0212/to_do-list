import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/utils.dart';

class TaskSlidable extends ConsumerWidget {
  const TaskSlidable({super.key, required this.child, required this.task});

  final Widget child;
  final Tasks task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(
          motion: const DrawerMotion(),
          dismissible: dismissiblePane(ref, context),
          children: [
            if (!task.isCompleted && !task.isDeleted)
              SlidableAction(
                onPressed: (context) {
                  ref.read(taskProvider.notifier).pinTask(task);
                  AppAlerts.showFlushBar(
                      context,
                      task.isPinned
                          ? "${task.title} unpinned"
                          : "${task.title} pinned",
                      AlertType.info);
                },
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                icon: task.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
              ),
            if (!task.isCompleted && !task.isDeleted)
              SlidableAction(
                  onPressed: (context) {
                    context.push('/editTask/${task.id}');
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.black,
                  icon: Icons.edit_outlined),
            SlidableAction(
              onPressed: (context) async {
                await ref
                    .read(taskProvider.notifier)
                    .deleteTask(task)
                    .then((value) {
                  AppAlerts.showFlushBar(
                      context,
                      task.isDeleted
                          ? "${task.title} restored"
                          : "${task.title} deleted",
                      AlertType.success);
                });
              },
              backgroundColor: task.isDeleted ? Colors.blue : Colors.red,
              foregroundColor: Colors.black,
              icon: task.isDeleted ? Icons.restart_alt : Icons.delete_outline,
            ),
            if (task.isDeleted)
              SlidableAction(
                onPressed: (actionContext) async {
                  AppAlerts.showAlertDeleteDialog(
                      context: context, ref: ref, task: task);
                },
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.black,
                icon: Icons.delete_forever,
              )
          ]),
      child: child,
    );
  }

  DismissiblePane dismissiblePane(WidgetRef ref, BuildContext context) {
    return DismissiblePane(
      closeOnCancel: true,
      confirmDismiss: () async {
        return await AppAlerts.showAlertDeleteDialog(
            context: context, ref: ref, task: task);
      },
      onDismissed: () async {
        if (!task.isDeleted) {
          await ref.read(taskProvider.notifier).deleteTask(task).then(
            (value) {
              AppAlerts.showFlushBar(
                  context, '${task.title} deleted', AlertType.success);
            },
          );
        }
      },
    );
  }
}
