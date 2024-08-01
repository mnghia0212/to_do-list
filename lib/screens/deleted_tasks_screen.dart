import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/widgets/widgets.dart';

class DeletedTasksScreen extends ConsumerWidget {
  const DeletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const DisplayText(
          text: "Deleted Tasks",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      
    );
  }
}