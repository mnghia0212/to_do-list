import 'package:flutter/material.dart';
import 'package:todo_app/widgets/widgets.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/data/data.dart';

class DisplayListOfTasks extends StatelessWidget {
  const DisplayListOfTasks(
      {super.key, required this.tasks, this.isCompletedTasks = false});
  final List<Tasks> tasks;
  final bool isCompletedTasks;

  @override
  Widget build(BuildContext context) {
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
                    onLongPress: () {
                      //TODO-delete task
                    },
                    onTap: () async {
                      //TODO-show task details
                      await showModalBottomSheet(
                          context: context,
                          builder: (ctx) {
                            return TaskDetails(task: task);
                          });
                    },
                    child: TaskTile(task: task));
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
