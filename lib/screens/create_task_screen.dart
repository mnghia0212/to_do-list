import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/config/routes/routes.dart';
import 'package:todo_app/providers/date_provider.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/widgets.dart';

import '../data/data.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(BuildContext context, GoRouterState state) =>
      const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: const [],
        title: const DisplayWhiteText(
            text: "Add a new task", fontSize: 25, fontWeight: FontWeight.bold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextfield(
                labelName: "Task title:",
                hintText: "Enter task title...",
                controller: _titleController,
              ),
              const Gap(30),
              const SelectCategory(),
              const Gap(30),
              const SelectDateTime(),
              const Gap(30),
              CommonTextfield(
                labelName: "Note:",
                hintText: "Take note for this task...",
                maxLines: 5,
                controller: _noteController,
              ),
              const Gap(30),
              ElevatedButton(
                  onPressed: _createTask,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 13),
                    child: DisplayWhiteText(text: "Save"),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    final category = ref.watch(categoryProvider);

    if (title.isNotEmpty) {
      final task = Tasks(
          title: title,
          note: note,
          time: Helpers.timeToString(time),
          date: DateFormat.yMMMd().format(date),
          category: category,
          isCompleted: false);

      await ref.read(taskProvider.notifier).createTask(task).then((value) {
        context.pop(RouteLocation.home);
        AppAlerts.showFlushBar(
          context,
          "New todo task created",
          AlertType.success
        );
       
      });
    } else {
      AppAlerts.showFlushBar(
        context,
        "Can't create a non-title task!",
        AlertType.error
      );
    }
  }
}
