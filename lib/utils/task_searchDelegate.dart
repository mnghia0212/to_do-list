import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/widgets/display_list_of_tasks.dart';
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
        ? const Center(child: Text("No task found"))
        :  Padding(
            padding: const EdgeInsets.all(10),
            child: DisplayListOfTasks(
              tasks: matchTasks,
              ),
        );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Tasks> matchTasks = getMatchTask();

    return matchTasks.isEmpty
        ? const Center(child: Text("No task found"))
        : Padding(
            padding: const EdgeInsets.all(10),
            child: DisplayListOfTasks(
              tasks: matchTasks,
              ),
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
