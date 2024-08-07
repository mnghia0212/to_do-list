import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/widgets.dart';

class CompletedTasksScreen extends ConsumerWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider).tasks;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const DisplayText(
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
              child: CommonContainer(
                backgroundColor: context.colorScheme.primaryContainer,
                child: tasks.isEmpty
                    ? const Center(
                        child: DisplayText(
                        text: "There is no completed todo task",
                        fontSize: 18,
                        color: Colors.black,
                      ))
                    : DisplayListOfTasks(
                        tasks: tasks,
                        isCompletedTasks: true
                      ),
              ),
            ),
            const Gap(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Done tasks: ${tasks.where((task) => task.isCompleted).length}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
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

// List<Tasks> _completedTask(List<Tasks> tasks, WidgetRef ref) {
//   final date = ref.watch(dateProvider);
//   final List<Tasks> filteredTask = [];

//   for (var task in tasks) {
//     if (task.isCompleted) {
//       final isTaskDay = Helpers.isTaskFromSelectedDate(task, date);
//       if (isTaskDay) {
//         filteredTask.add(task);
//       }
//     }
//   }
//   return filteredTask;
// }
