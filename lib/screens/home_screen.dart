import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/config/routes/routes.dart';
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

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: deviceSize.width,
                height: deviceSize.height * 0.3,
                color: colors.primaryFixed,
                child: const Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DisplayWhiteText(
                          text: "June 17th 2024",
                          fontSize: 20,
                        ),
                        Gap(10),
                        DisplayWhiteText(
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
                      tasks: taskState.tasks,

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
                      isCompletedTasks: true,
                      tasks: taskState.tasks
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () => context.push(RouteLocation.createTask),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 13),
                child: DisplayWhiteText(
                  text: 'Add New Task',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
