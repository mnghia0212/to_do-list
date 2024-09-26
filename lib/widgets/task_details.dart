import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:todo_app/config/routes/app_routes.dart';
import 'package:todo_app/data/models/models.dart';
import 'package:todo_app/providers/tasks/tasks.dart';
import 'package:todo_app/utils/app_alerts.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:todo_app/widgets/circle_container.dart';

class TaskDetails extends ConsumerWidget {
  const TaskDetails({super.key, required this.task});
  final Tasks task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = context.textTheme;
    final noteText = task.note.isEmpty ? "No note for this task" : task.note;
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Visibility(
              visible: task.isCompleted,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Completed",
                    style: TextStyle(fontSize: 17),
                  ),
                  const Gap(3),
                  Icon(
                    Icons.check_box,
                    color: task.category.color,
                  ),
                ],
              ),
            ),
            const Gap(30),
            CircleContainer(
              color: task.category.color,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(task.category.icon),
              ),
            ),
            const Gap(15),
            Text(
              task.title,
              style: textStyle.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(10),
            Visibility(visible: !task.isCompleted, child: const Gap(10)),
            Visibility(
                visible:
                    !task.isCompleted && task.date != null && task.time != null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Complete on ${task.date}, ${task.time}"),
                    const Gap(3),
                    Icon(
                      Icons.check_box,
                      color: task.category.color,
                    )
                  ],
                )),
            Visibility(
                visible: task.date == null || task.time == null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (task.date == null && task.time == null)
                      const Text("No date, no time")
                    else if (task.date != null && task.time == null)
                      Text("Complete on ${task.date}")
                    else if (task.date == null && task.time != null)
                      Text("Complete on ${task.date}, ${task.time}")
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Divider(
                thickness: 1.5,
                color: task.category.color,
              ),
            ),
            Text(
              noteText,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
      Positioned(
          top: 8,
          right: 8,
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Icon(
              Icons.close,
            ),
          )),
      Positioned(bottom: 10, left: 10, child: detailHandler(task, ref, context))
    ]);
  }

  Widget detailHandler(Tasks task, WidgetRef ref, BuildContext context) {
    if (!task.isCompleted && !task.isDeleted) {
      if (task.isPinned) {
        return Row(
          children: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 3.0, color: task.category.color),
                ),
                onPressed: () {
                  ref.read(taskProvider.notifier).pinTask(task);
                  Navigator.pop(context);
                  AppAlerts.showFlushBar(
                      context, "${task.title} pinned", AlertType.success);
                },
                child: const Text("Unpin")),
            const Gap(5),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 3.0, color: task.category.color),
                ),
                onPressed: () => context.push('/editTask/${task.id}'),
                child: const Text("Edit")),
            const Gap(5),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 3.0, color: task.category.color),
                ),
                onPressed: () {
                  ref.read(taskProvider.notifier).deleteTask(task);
                  Navigator.pop(context);
                  AppAlerts.showFlushBar(
                      context, "${task.title} removed", AlertType.success);
                },
                child: const Text("Remove")),
          ],
        );
      } else {
        return Row(
          children: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 3.0, color: task.category.color),
                ),
                onPressed: () {
                  ref.read(taskProvider.notifier).pinTask(task);
                  Navigator.pop(context);
                  AppAlerts.showFlushBar(
                      context, "${task.title} pinned", AlertType.success);
                },
                child: const Text("Pin")),
            const Gap(5),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 3.0, color: task.category.color),
                ),
                onPressed: () => context.push('/editTask/${task.id}'),
                child: const Text("Edit")),
            const Gap(5),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 3.0, color: task.category.color),
                ),
                onPressed: () {
                  ref.read(taskProvider.notifier).deleteTask(task);
                  Navigator.pop(context);
                  AppAlerts.showFlushBar(
                      context, "${task.title} removed", AlertType.success);
                },
                child: const Text("Remove")),
          ],
        );
      }
    } else if (task.isCompleted && !task.isDeleted) {
      return Row(
        children: [
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 3.0, color: task.category.color),
              ),
              onPressed: () {
                ref.read(taskProvider.notifier).updateTask(task);
                Navigator.pop(context);
                AppAlerts.showFlushBar(
                    context, "${task.title} uncompleted", AlertType.info);
              },
              child: const Text("Incomplete")),
          const Gap(5),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 3.0, color: task.category.color),
              ),
              onPressed: () {
                ref.read(taskProvider.notifier).deleteTask(task);
                Navigator.pop(context);
                AppAlerts.showFlushBar(
                    context, "${task.title} removed", AlertType.success);
              },
              child: const Text("Remove")),
        ],
      );
    } else {
      return Row(
        children: [
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 3.0, color: task.category.color),
              ),
              onPressed: () {
                ref.read(taskProvider.notifier).deleteTask(task);
                Navigator.pop(context);
                AppAlerts.showFlushBar(
                    context, "${task.title} restore", AlertType.success);
              },
              child: const Text("Restore")),
          const Gap(5),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 3.0, color: task.category.color),
              ),
              onPressed: () {
                ref.read(taskProvider.notifier).removeTask(task);
                Navigator.pop(context);
                AppAlerts.showFlushBar(
                    context, "${task.title} deleted", AlertType.success);
              },
              child: const Text("Delete")),
        ],
      );
    } 
  }
}
