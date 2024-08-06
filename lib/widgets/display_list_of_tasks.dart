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
    // final emptyTaskMessage = isCompletedTasks
    //     ? "There is no completed task"
    //     : "There is no todo task!";

    // return tasks.isEmpty
    //     ? Center(
    //         child: DisplayText(
    //           text: emptyTaskMessage,
    //           fontSize: 20,
    //           color: Colors.black,
    //         ),
    //       ):
    final completedTasks = tasks.where((task) => task.isCompleted).toList();
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
            child: Slidable(
                key: UniqueKey(),
                // startActionPane: ActionPane(
                //   motion: const ScrollMotion(),
                //   dismissible:
                //       DismissiblePane(onDismissed: () async {
                //     await ref
                //         .read(taskProvider.notifier)
                //         .updateTask(task)
                //         .then((value) {
                //       AppAlerts.showFlushBar(
                //           context,
                //           task.isCompleted
                //               ? '${task.title} incompleted'
                //               : '${task.title} completed',
                //           AlertType.info);
                //     });
                //   }),
                //   children: [
                //     SlidableAction(
                //       onPressed: (context) async {
                //         await ref
                //             .read(taskProvider.notifier)
                //             .updateTask(task)
                //             .then((value) {
                //           AppAlerts.showFlushBar(
                //               context,
                //               task.isCompleted
                //                   ? '${task.title} incompleted'
                //                   : '${task.title} completed',
                //               AlertType.info);
                //         });
                //       },
                //       backgroundColor: Colors.greenAccent,
                //       foregroundColor: Colors.black,
                //       icon: task.isCompleted
                //           ? Icons.close
                //           : Icons.check,
                //     ),
                //   ],
                // ),
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
                      SlidableAction(
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
                        icon: Icons.delete_outline,
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
        return const Gap(15);
      },
    );
  }
}
