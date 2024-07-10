import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/widgets/widgets.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/data/data.dart';

class DisplayListOfTasks extends ConsumerWidget {
  const DisplayListOfTasks(
      {super.key, required this.tasks, this.isCompletedTasks = false});

  final List<Tasks> tasks;
  final bool isCompletedTasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    final height =
        isCompletedTasks ? deviceSize.height * 0.25 : deviceSize.height * 0.3;
    final emptyTaskMessage = isCompletedTasks
        ? "There is no completed task"
        : "There is no todo task!";

    return CommonContainer(
      height: height,
      child: tasks.isEmpty
          ? Center(
              child: Text(
                emptyTaskMessage,
                style: context.textTheme.titleLarge,
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: tasks.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final task = tasks[index];

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
                    child: Dismissible(
                        key: ValueKey<int>(index),
                        confirmDismiss: (DismissDirection direction) async {
                          if (direction == DismissDirection.endToStart) {
                            await AppAlerts.showAlertDeleteDialog(
                                context: context, ref: ref, task: task);
                          }
                          return null;
                        },
                        secondaryBackground: Container(
                          color: Colors.red,
                          child: const Icon(color: Colors.black, Icons.delete),
                        ),
                        background: Container(
                          color: context.colorScheme.primaryContainer,
                        ),
                        child: TaskTile(
                          task: task,
                          onCompleted: (value) async {
                            await ref
                                .read(taskProvider.notifier)
                                .updateTask(task)
                                .then((value) {
                              AppAlerts.displaySnackBar(
                                  context,
                                  task.isCompleted
                                      ? '${task.title} incompleted'
                                      : '${task.title} completed');
                            });
                          },
                        )));
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 2,
                );
              },
            ),
    );
  }
}
