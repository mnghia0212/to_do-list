import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/config/routes/routes.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
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
    final inCompletedTasks = _incompletedTask(taskState.tasks, ref);
    final selectedDate = ref.watch(dateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: TaskSearchdelegate(ref));
              },
              icon: const Icon(Icons.search))
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
                padding: const EdgeInsets.only(top: 50),
                width: deviceSize.width,
                height: deviceSize.height * 0.3,
                color: colors.primaryFixed,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DisplayWhiteText(
                        text:
                            "Hi, today is ${DateFormat.yMMMd().format(DateTime.now())}",
                        fontSize: 15,
                      ),
                      const DisplayWhiteText(
                        text: "My Todo List",
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                      const Gap(5),
                    ]),
              )
            ],
          ),
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const DisplayWhiteText(
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
                                  child: DisplayWhiteText(
                                    text:
                                        DateFormat.yMMMd().format(selectedDate),
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
                      SizedBox(
                        height: deviceSize.height * 0.59,
                        child: DisplayListOfTasks(
                          tasks: inCompletedTasks,
                          backgroundColor: colors.primaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Tasks> _incompletedTask(List<Tasks> tasks, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final List<Tasks> filteredTask = [];

    for (var task in tasks) {
      if (!task.isCompleted) {
        final isTaskDay = Helpers.isTaskFromSelectedDate(task, date);
        if (isTaskDay) {
          filteredTask.add(task);
        }
      }
    }
    return filteredTask;
  }
}

