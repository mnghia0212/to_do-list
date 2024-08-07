import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/config/routes/route_location.dart';
import 'package:todo_app/providers/navigation_provider.dart';
import 'package:todo_app/screens/screens.dart';
import 'package:todo_app/screens/setting_screen.dart';
import 'package:todo_app/utils/extensions.dart';

class BottomNavigator extends ConsumerWidget {
  static BottomNavigator builder(BuildContext context, GoRouterState state) =>
      const BottomNavigator();
  const BottomNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);
    final colors = context.colorScheme;

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            shape:const CircleBorder(),
            onPressed: () => context.push(RouteLocation.createTask),
            splashColor: colors.primaryContainer,
            tooltip: "Tap to create new task",
            backgroundColor: colors.primary,
            child: const Icon(Icons.add)
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          currentIndex: currentIndex,
           onTap: (value) {
            if (value != 2) {
              ref.read(navigationProvider.notifier).state = value;
            }
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
                backgroundColor: Colors.white,
                icon: SizedBox.shrink(),
                label: "",
                
  ),
            BottomNavigationBarItem(
                icon: Icon(Icons.delete),
                label: "Deleted",
                tooltip: "Tap to see deleted tasks"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Setting",
                tooltip: "Tap to make some settings"),
          ],
        ),
        body: IndexedStack(
          index: currentIndex,
          children: const [
            HomeScreen(),
            CompletedTasksScreen(),
            SizedBox.shrink(),
            DeletedTasksScreen(),
            SettingScreen()
          ],
        ));
  }
}
