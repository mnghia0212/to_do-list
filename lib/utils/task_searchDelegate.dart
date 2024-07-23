import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/widgets/task_tile.dart';

class TaskSearchdelegate extends SearchDelegate {
  final WidgetRef ref;

  TaskSearchdelegate(this.ref);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Tasks> matchTasks = getMatchTask();

    return matchTasks.isEmpty
        ? const Center(child: 
            Text("No task found")
        )
        : ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            itemCount: matchTasks.length,
            itemBuilder: (context, index) {
              final task = matchTasks[index];

              return TaskTile(task: task);
            },
            separatorBuilder: (context, index) {
              return const Gap(17);
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Tasks> matchTasks = getMatchTask();

    return matchTasks.isEmpty
        ? const Center(child: const Text("No task found"))
        : ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            itemCount: matchTasks.length,
            itemBuilder: (context, index) {
              final task = matchTasks[index];

              return TaskTile(task: task);
            },
            separatorBuilder: (context, index) {
              return const Gap(17);
            },
          );
  }

  List<Tasks> getMatchTask() {
    final tasks = ref.watch(taskProvider).tasks;

    if (query.isEmpty) {
      return tasks;
    } else {
      return tasks
          .where((task) =>
              task.title.toLowerCase().contains(query.toLowerCase()) ||
              task.note.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
