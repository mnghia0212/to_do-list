
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/config/routes/route_location.dart';
import 'package:todo_app/notifications/notifications.dart';
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
    final deviceSize = context.deviceSize;

    return Scaffold(        
        bottomNavigationBar: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colors.primary,
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: colors.primary,
                elevation: 0,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedItemColor: Colors.white,
                selectedIconTheme: const IconThemeData(
                  color: Colors.white,
                  opacity: 1
                ),
                unselectedIconTheme: const IconThemeData(
                  color: Colors.white,
                  opacity: 0.5
                ),
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
                      icon:  SizedBox.shrink(),
                      label: "Create task",
                      tooltip: "Tap to create new task"
                      
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
          ),

          Positioned(
            bottom: 10,
            left: deviceSize.width / 2 - 32.5,
            child: SizedBox(
              width: 65,
              height: 45,
              child: FloatingActionButton(
                  onPressed: () => context.push(RouteLocation.createTask),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: colors.primary, width: 1),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  splashColor: colors.primaryContainer,
                  tooltip: "Tap to create new task",
                  child: Icon(Icons.add, color: colors.primary,size: 28,)
              ),
            ),
          )
          ] 
        ),
        body: IndexedStack(
          index: currentIndex,
          children: const [
            HomeScreen(),
            CompletedTasksScreen(),
            CreateTaskScreen(),
            DeletedTasksScreen(),
            SettingScreen()
          ],
        ));
  }
}
