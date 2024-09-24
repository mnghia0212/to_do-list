import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/config/config.dart';
import 'package:todo_app/config/routes/routes_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';

class ToDoApp extends ConsumerWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeConfig = ref.watch(routesProvider);
    final isDarkTheme = ref.watch(themeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme ? AppTheme.dark : AppTheme.light,
      darkTheme: ThemeData.dark(),
      routerConfig: routeConfig,
    );
  }
}
