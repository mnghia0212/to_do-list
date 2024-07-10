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
    final completedTasks = _completedTask(taskState.tasks, ref);
    final inCompletedTasks = _incompletedTask(taskState.tasks, ref);
    final selectedDate = ref.watch(dateProvider);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (value) {
          
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.mark_chat_read),
            label: "Completed"
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: "Deleted"
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: deviceSize.width,
                height: deviceSize.height * 0.3,
                color: colors.primaryFixed,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => Helpers.selectDate(context, ref),
                          child: DisplayWhiteText(
                            text: DateFormat.yMMMd().format(selectedDate),
                            fontSize: 20,
                          ),
                        ),
                        const Gap(10),
                        const DisplayWhiteText(
                          text: "My Todo List",
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        )
                      ]),
                ),
              )
            ],
          ),
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DisplayListOfTasks(
                      tasks: inCompletedTasks,
                    ),
                    const Gap(20),
                    Text(
                      'Completed tasks',
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(20),
                    DisplayListOfTasks(
                        isCompletedTasks: true, tasks: completedTasks),
                    const Gap(20),
                    ElevatedButton(
                      onPressed: () => context.push(RouteLocation.createTask),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 13),
                        child: DisplayWhiteText(
                          text: 'Add New Task',
                        ),
                      ),
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

  List<Tasks> _completedTask(List<Tasks> tasks, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final List<Tasks> filteredTask = [];

    for (var task in tasks) {
      if (task.isCompleted) {
        final isTaskDay = Helpers.isTaskFromSelectedDate(task, date);
        if (isTaskDay) {
          filteredTask.add(task);
        }
      }
    }
    return filteredTask;
  }
}
