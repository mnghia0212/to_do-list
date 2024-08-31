import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/config/routes/routes.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/widgets.dart';

import '../data/data.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  const CreateTaskScreen({this.id, super.key});

  final String? id;

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _noteController;
  Tasks? task;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.id != null) {
      task = getTaskById(widget.id);
      _titleController = TextEditingController(text: task?.title ?? '');
      _noteController = TextEditingController(text: task?.note ?? '');
    } else {
      _titleController = TextEditingController();
      _noteController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = task != null;

    return Scaffold(
      appBar: AppBar(
        // actions: const [],
        title: DisplayText(
          text: isEditing ? "Edit task" : "Add a new task",
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
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
                  onPressed: _saveAndCreateTask,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 13),
                    child: DisplayText(text: "Save"),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Tasks? getTaskById(String? id) {
    if (id == null) return null;

    try {
      final taskId = int.tryParse(id);
      if (taskId == null) return null;

      return ref
          .watch(taskProvider)
          .tasks
          .firstWhere((task) => task.id == taskId);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  void _saveAndCreateTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    final category = ref.watch(categoryProvider);

    if (title.isNotEmpty) {
      if (task != null) {
        final tasks = task!.copyWith(
            title: title,
            note: note,
            date: date != null
                ? DateFormat.yMMMd().format(date)
                : task!.date,
            time: Helpers.timeToString(time),
            category: category);

        await ref.read(taskProvider.notifier).editTask(tasks).then((value) {
          context.pop(RouteLocation.bottomNavigator);
          AppAlerts.showFlushBar(
              context, "Task updated successfully", AlertType.success);
        });
      } else {
        final task = Tasks(
            title: title,
            note: note,
            time: Helpers.timeToString(time),
            date: date != null
                ? DateFormat.yMMMd().format(date)
                : DateFormat.yMMMd().format(DateTime.now()),
            category: category,
            isCompleted: false,
            isPinned: false,
            isDeleted: false);

        await ref.read(taskProvider.notifier).createTask(task).then((value) {
          context.pop(RouteLocation.bottomNavigator);
          AppAlerts.showFlushBar(
              context, "New task created", AlertType.success);
        });
      }
    } else {
      AppAlerts.showFlushBar(
          context, "Can't create a task without title!", AlertType.error);
    }
  }
}
