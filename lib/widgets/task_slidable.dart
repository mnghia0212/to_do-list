import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/utils.dart';

class TaskSlidable extends ConsumerWidget {
  const TaskSlidable({super.key, required this.child,required this.task});

  final Widget child;
  final Tasks task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
        key: UniqueKey(),
        endActionPane: ActionPane(
            motion: const DrawerMotion(),
            dismissible: DismissiblePane(
              onDismissed: () async {
                await ref.read(taskProvider.notifier).deleteTask(task).then(
                  (value) {
                    AppAlerts.showFlushBar(
                        context,
                        '${task.title} deleted successfully',
                        AlertType.success);
                  },
                );
              },
            ),
            children: [
              if (!task.isCompleted || !task.isDeleted) SlidableAction(
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
                  icon: task.isPinned
                      ? Icons.push_pin
                      : Icons.push_pin_outlined,
                ),
              SlidableAction(
                onPressed: (context) async {
                  await ref
                      .read(taskProvider.notifier)
                      .deleteTask(task)
                      .then((value) {
                    AppAlerts.showFlushBar(
                        context,
                        '${task.title} deleted successfully',
                        AlertType.success);
                  });
                },
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.black,
                icon: task.isDeleted ? Icons.delete : Icons.delete_outline,
              ),
            ]),
            child: child,
            );
  }
}
