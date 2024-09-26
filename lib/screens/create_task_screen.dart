import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/config/routes/routes.dart';
import 'package:todo_app/notifications/notifications.dart';
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
      task = Helpers.getTaskById(widget.id, ref);
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
        backgroundColor: context.colorScheme.primaryContainer,
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
                labelName: "Title:",
                hintText: "New task...",
                controller: _titleController,
              ),
              const Gap(30),
              SelectCategory(
                task: task,
              ),
              const Gap(30),
              SelectDateTime(task: task),
              const Gap(30),
              CommonTextfield(
                labelName: "Note:",
                hintText: "Take note for this task...",
                maxLines: 5,
                controller: _noteController,
              ),
              const Gap(30),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colorScheme.primaryContainer
                  ),
                  onPressed: _saveAndCreateTask,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: DisplayText(
                      text: task != null ? "Save" : "Create",
                      fontSize: 25,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _saveAndCreateTask() async {
    final title = _titleController.text.trim().isEmpty
        ? "New task"
        : _titleController.text.trim();
    final note = _noteController.text.trim();
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    final category = ref.watch(categoryProvider);

    if (task != null) {
      // ** edit task
      final tasks = task!.copyWith(
          title: title,
          note: note,
          date: date != null ? DateFormat.yMMMd().format(date) : task!.date,
          time: time != null ? Helpers.timeToString(time) : task!.time,
          category: category);

      await ref.read(taskProvider.notifier).editTask(tasks).then((value) {
        context.pop(RouteLocation.bottomNavigator);
        AppAlerts.showFlushBar(
            context, "Task updated successfully", AlertType.success);
      });
    } else {
      // *create task
      final task = Tasks(
          title: title,
          note: note,
          time: time != null ? Helpers.timeToString(time) : null,
          date: date != null
              ? DateFormat.yMMMd().format(date)
              : time != null
                  ? DateFormat.yMMMd().format(DateTime.now())
                  : null,
          category: category,
          isCompleted: false,
          isPinned: false,
          isDeleted: false);

      

      await ref.read(taskProvider.notifier).createTask(task).then((value) {
        context.pop(RouteLocation.home);
        AppAlerts.showFlushBar(context, "New task created", AlertType.success);
      });
    }
  }
}
