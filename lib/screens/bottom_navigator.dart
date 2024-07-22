import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/providers/navigation_provider.dart';
import 'package:todo_app/screens/screens.dart';

class BottomNavigator extends ConsumerWidget {
  static BottomNavigator builder(BuildContext context, GoRouterState state) =>
      const BottomNavigator();
  const BottomNavigator({super.key});

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
          children: const [
            HomeScreen(),
            CompletedTasksScreen(),
            DeletedTasksScreen()
          ],
        ));
  }
}
