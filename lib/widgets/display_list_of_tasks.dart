import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/widgets/widgets.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/data/data.dart';

class DisplayListOfTasks extends ConsumerWidget {
  const DisplayListOfTasks(
      {super.key,
      required this.tasks,
      this.isCompletedTasks = false,
      this.isPinnedTasks = false});

  final List<Tasks> tasks;
  final bool isCompletedTasks;
  final bool isPinnedTasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedTasks = tasks.where((task) => task.isCompleted).toList();

    return ListView.separated(
      itemCount: isCompletedTasks ? completedTasks.length : tasks.length,
      shrinkWrap: true,
      physics: isPinnedTasks
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final task = isCompletedTasks ? completedTasks[index] : tasks[index];

        return InkWell(
            onTap: () async {
              //TODO-show task details
              await showModalBottomSheet(
                  context: context,
                  builder: (ctx) {
                    return TaskDetails(task: task);
                  });
            },
            //TODO-delete task
            child: TaskSlidable(
              task: task,
              child: TaskTile(
                  task: task,
                  onCompleted: (value) async {
                    await ref
                        .read(taskProvider.notifier)
                        .updateTask(task)
                        .then((value) {
                      AppAlerts.showFlushBar(
                          context,
                          task.isCompleted
                              ? '${task.title} incompleted'
                              : '${task.title} completed',
                          AlertType.info);
                    });
                  },
              ), 
            )
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Gap(15);
      },
    );
  }
}
