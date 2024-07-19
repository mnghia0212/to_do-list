import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/app_alerts.dart';
import 'package:todo_app/widgets/widgets.dart';

class DisplayPinnedTasks extends ConsumerWidget {
  const DisplayPinnedTasks({super.key, required this.tasks});

  final List<Tasks> tasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinnedTasks = tasks.where((tasks) => tasks.isPinned).toList();

    return Container(
        decoration: BoxDecoration(
            border: pinnedTasks.isEmpty ? null :  const BorderDirectional(
                bottom: BorderSide(color: Colors.blueGrey, width: 1))),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: pinnedTasks.isEmpty ? 0 : 10),
          itemCount: pinnedTasks.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final pinnedTask = pinnedTasks[index];

            return InkWell(
                onTap: () async {
                  //TODO-show task details
                  await showModalBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return TaskDetails(task: pinnedTask);
                      });
                },
                //TODO-delete task
                child: Slidable(
                    key: UniqueKey(),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () async {
                        await ref
                            .read(taskProvider.notifier)
                            .updateTask(pinnedTask)
                            .then((value) {
                          AppAlerts.showFlushBar(
                              context,
                              pinnedTask.isCompleted
                                  ? '${pinnedTask.title} incompleted'
                                  : '${pinnedTask.title} completed',
                              AlertType.info);
                        });
                      }),
                      children: [
                        SlidableAction(
                          onPressed: (context) async {
                            await ref
                                .read(taskProvider.notifier)
                                .updateTask(pinnedTask)
                                .then((value) {
                              AppAlerts.showFlushBar(
                                  context,
                                  pinnedTask.isCompleted
                                      ? '${pinnedTask.title} incompleted'
                                      : '${pinnedTask.title} completed',
                                  AlertType.info);
                            });
                          },
                          backgroundColor: Colors.greenAccent,
                          foregroundColor: Colors.black,
                          icon: pinnedTask.isCompleted
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
                                .deleteTask(pinnedTask)
                                .then(
                              (value) {
                                AppAlerts.showFlushBar(
                                    context,
                                    '${pinnedTask.title} deleted successfully',
                                    AlertType.success);
                              },
                            );
                          },
                        ),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              ref
                                  .read(taskProvider.notifier)
                                  .pinTask(pinnedTask);
                              AppAlerts.showFlushBar(
                                  context,
                                  "${pinnedTask.title} unpinned",
                                  AlertType.info);
                            },
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.black,
                            icon: Icons.star,
                          ),
                          SlidableAction(
                            onPressed: (context) async {
                              await ref
                                  .read(taskProvider.notifier)
                                  .deleteTask(pinnedTask)
                                  .then((value) {
                                AppAlerts.showFlushBar(
                                    context,
                                    '${pinnedTask.title} deleted successfully',
                                    AlertType.success);
                              });
                            },
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.black,
                            icon: Icons.delete_outline,
                          ),
                        ]),
                    child: TaskTile(
                      task: pinnedTask,
                      onCompleted: (value) async {
                        await ref
                            .read(taskProvider.notifier)
                            .updateTask(pinnedTask)
                            .then((value) {
                          AppAlerts.showFlushBar(
                              context,
                              pinnedTask.isCompleted
                                  ? '${pinnedTask.title} incompleted'
                                  : '${pinnedTask.title} completed',
                              AlertType.info);
                        });
                      },
                    )));
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Gap(17);
          },
        ));
  }
}
