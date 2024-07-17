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
      {super.key, required this.tasks, this.isCompletedTasks = false});

  final List<Tasks> tasks;
  final bool isCompletedTasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emptyTaskMessage = isCompletedTasks
        ? "There is no completed task"
        : "There is no todo task!";

    return CommonContainer(
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
                    child: Slidable(
                        key: UniqueKey(),
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          dismissible: DismissiblePane(
                            onDismissed: () async {
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
                                }
                              );
                            }
                          ),
                          children: [
                            SlidableAction(
                              onPressed: (context) async {
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
                                }
                              );
                            },
                              backgroundColor: Colors.greenAccent,
                              foregroundColor: Colors.black,
                              icon: task.isCompleted
                                      ? Icons.close
                                      : Icons.check,
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            dismissible: DismissiblePane(
                              onDismissed: () async {
                                await ref
                                    .read(taskProvider.notifier)
                                    .deleteTask(task)
                                    .then(
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
                              const SlidableAction(
                                onPressed: null,
                                backgroundColor: Colors.amber,
                                foregroundColor: Colors.black,
                                icon: Icons.push_pin,
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
                                          AlertType.success
                                        );                                      });
                                },                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.black,
                                icon: Icons.delete,
                              ),
                            ]),
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
                        )));
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Gap(17);
              },
            ),
    );
  }
}
