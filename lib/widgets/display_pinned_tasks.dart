import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/app_alerts.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:todo_app/widgets/widgets.dart';

class DisplayPinnedTasks extends ConsumerWidget {
  const DisplayPinnedTasks({super.key, required this.tasks});

  final List<Tasks> tasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinnedTasks = tasks.where((tasks) => tasks.isPinned).toList();
    final unpinnedTasks = tasks.where((tasks) => !tasks.isPinned).toList();

    return CommonContainer(
      height: context.deviceSize.height * 0.64,
      backgroundColor: context.colorScheme.primaryContainer,
      child: tasks.isEmpty ?
      const Center(child: DisplayText(
        text: "There is no todo task",
        fontSize: 18,
      )) :
      SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            DisplayListOfTasks(tasks: pinnedTasks, isPinnedTasks: true),
            if(pinnedTasks.isNotEmpty) const Divider(thickness: 2),
            DisplayListOfTasks(tasks: unpinnedTasks, isPinnedTasks: true)
          ],
        ),
      )
    );
  }
}
