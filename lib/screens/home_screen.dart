import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/config/routes/routes.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/navigation_provider.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/screens/completed_tasks_screen.dart';
import 'package:todo_app/screens/deleted_tasks_screen.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            ref.read(navigationProvider.notifier).state = value;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                tooltip: "Tap to go to home screen"),
            BottomNavigationBarItem(
                icon: Icon(Icons.done_all_outlined),
                label: "Completed",
                tooltip: "Tap to see completed tasks"),
            BottomNavigationBarItem(
                icon: Icon(Icons.delete),
                label: "Deleted",
                tooltip: "Tap to see deleted tasks"),
          ],
        ),
        body: IndexedStack(
          index: currentIndex,
          children: [
            _buildHomeScreen(context, ref),
            const CompletedTasksScreen(),
            const DeletedTasksScreen()
          ],
        ));
  }

  Widget _buildHomeScreen(BuildContext context, WidgetRef ref) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final taskState = ref.watch(taskProvider);
    final inCompletedTasks = _incompletedTask(taskState.tasks, ref);
    final selectedDate = ref.watch(dateProvider);
    return Stack(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50),
              width: deviceSize.width,
              height: deviceSize.height * 0.3,
              color: colors.primaryFixed,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DisplayWhiteText(
                    text: "Hi, today is ${DateFormat.yMMMd().format(DateTime.now())}",
                    fontSize: 15,
                  ),
                  const DisplayWhiteText(
                    text: "My Todo List",
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  const Gap(5),
                  
                ]
              ),
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
                          text: "Filter by date: ",
                          fontSize: 15,
                        ),
                        const Gap(5),
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey, 
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () => Helpers.selectDate(context, ref),
                                child: DisplayWhiteText(
                                  text: DateFormat.yMMMd().format(selectedDate),
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
                      height: deviceSize.height * 0.56,
                      child: DisplayListOfTasks(
                        tasks: inCompletedTasks,
                      ),
                    ),
                    const Gap(15),
                   
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
        ),
      ],
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
