import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:todo_app/widgets/widgets.dart';

class DeletedTasksScreen extends ConsumerWidget {
  const DeletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks =
        ref.watch(taskProvider).tasks.where((task) => task.isDeleted).toList();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: context.colorScheme.primary,
          centerTitle: true,
          title: const DisplayTittleText(
            text: "Deleted Tasks",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: tasks.isEmpty
            ? const Center(
                child: DisplayText(
                  text: "No deleted tasks",
                  fontSize: 18,
                  color: Colors.black,
                ),
              )
            : ListView.separated(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskSlidable(
                    task: task,
                    child: InkWell(
                      onTap: () async {
                        //TODO-show task details
                        await showModalBottomSheet(
                            context: context,
                            builder: (ctx) {
                              return TaskDetails(task: task);
                            });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: context.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleContainer(
                                      color:
                                          task.category.color.withOpacity(0.2),
                                      child: Center(
                                        child: Icon(
                                          task.category.icon,
                                        ),
                                      ),
                                    ),
                                    const Gap(15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DisplayText(
                                          text: task.title,
                                          fontSize: 16,
                                        ),
                                        if (task.date != null &&
                                            task.time != null)
                                          Row(
                                            children: [
                                              Text('${task.date}, '),
                                              Text("${task.time}"),
                                            ],
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Visibility(
                                      visible: task.isCompleted,
                                      child: Icon(Icons.check_box))
                                  ],
                                ),
                                
                              ],
                            )),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Gap(10);
                },
              ));
  }
}
