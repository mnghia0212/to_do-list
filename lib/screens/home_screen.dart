import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/config/routes/routes.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/helpers.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final taskState = ref.watch(taskProvider);
    //final inCompletedTasks = _incompleteTask(taskState.tasks, ref);
    final selectedDate = ref.watch(dateProvider);

    final filteredTasks = selectedDate != null
     ? _filterTaskByDate(taskState.tasks, selectedDate)
     : taskState.tasks;
    return Scaffold(
      
      appBar: AppBar(
        title: DisplayText(
          text: "Hi, today is ${DateFormat.yMMMd().format(DateTime.now())}",
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ) ,
        centerTitle: true,
        backgroundColor: colors.primaryFixed,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                            color: const Color.fromARGB(60, 212, 204, 204),
              ),
              child: IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: TaskSearchdelegate(ref));
                  },
                  icon: const Icon(Icons.search)),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => context.push(RouteLocation.createTask),
          splashColor: colors.primaryContainer,
          tooltip: "Tap to create new task",
          backgroundColor: colors.primary,
          child: const Icon(Icons.add_task)),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: deviceSize.width,
                height: deviceSize.height * 0.25,
                color: colors.primaryFixed,
                child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    DisplayText(
                      text: "My todo list",
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ) ,
                ]),
              )
            ],
          ),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const DisplayText(
                          text: "Filter: ",
                          fontSize: 15,
                        ),
                        const Gap(5),
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () => Helpers.selectDate(context, ref),
                                child: DisplayText(
                                  text:
                                    selectedDate != null
                                      ? Helpers.dateFormatter(selectedDate)
                                      : "Select date",
                                  fontSize: 15,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const Gap(10),
                    DisplayPinnedTasks(tasks: filteredTasks
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Tasks> _filterTaskByDate(List<Tasks> tasks, DateTime selectedDate) {
    final List<Tasks> filteredTask = [];
    
    for (var task in tasks) {
      if (!task.isCompleted) {
        final isTaskDay = Helpers.isTaskFromSelectedDate(task, selectedDate);
        if (isTaskDay) {
          filteredTask.add(task);
        }
      }
    }
    return filteredTask;
  }
}

