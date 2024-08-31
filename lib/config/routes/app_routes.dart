import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/config/routes/route_location.dart';
import 'package:todo_app/screens/screens.dart';

final navigationKey = GlobalKey<NavigatorState>();
final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomeScreen.builder, //c2: (context, state) => HomeScreen() - Ko
    //chuyen builder o screen
  ),
  GoRoute(
    path: RouteLocation.createTask,
    parentNavigatorKey: navigationKey,
    builder: (context, state) => const CreateTaskScreen(),
  ),
  GoRoute(
    path: RouteLocation.editTask,
    parentNavigatorKey: navigationKey,
    builder: (context, state) {
      final taskId = state.pathParameters['id'];
      return CreateTaskScreen(id: taskId);
    },
  ),
  GoRoute(
    path: RouteLocation.bottomNavigator,
    parentNavigatorKey: navigationKey,
    builder: BottomNavigator.builder,
  ),
];
