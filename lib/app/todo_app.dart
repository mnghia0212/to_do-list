import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/config/config.dart';
import 'package:todo_app/config/routes/routes_provider.dart';

class ToDoApp extends ConsumerWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeConfig = ref.watch(routesProvider);

    return  MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: routeConfig,
    );
  } 
}
