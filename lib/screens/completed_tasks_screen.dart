import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/data/models/models.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/widgets.dart';

class CompletedTasksScreen extends ConsumerWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskProvider);
    final completedTasks = _completedTask(taskState.tasks, ref);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const DisplayWhiteText(
          text: "Completed Tasks",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
        child: Column(
          children: [
            Expanded(
              child: DisplayListOfTasks(tasks: completedTasks),
            ),
            const Gap(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Number of completed tasks: ${completedTasks.length}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                const Gap(3),
                const Icon(Icons.check_box_rounded)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<Tasks> _completedTask(List<Tasks> tasks, WidgetRef ref) {
  final date = ref.watch(dateProvider);
  final List<Tasks> filteredTask = [];

  for (var task in tasks) {
    if (task.isCompleted) {
      final isTaskDay = Helpers.isTaskFromSelectedDate(task, date);
      if (isTaskDay) {
        filteredTask.add(task);
      }
    }
  }
  return filteredTask;
}
