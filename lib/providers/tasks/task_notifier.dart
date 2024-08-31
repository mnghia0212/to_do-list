import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  final TaskRepositories _repository;

  TaskNotifier(this._repository) : super(const TaskState.initial()) {
    getTasks();
  }

  Future<void> createTask(Tasks task) async {
    try {
      await _repository.createTask(task);
      getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteTask(Tasks task) async {
    try {
      final isDeleted = !task.isDeleted;
      final deleteTask = task.copyWith(isDeleted: isDeleted);
      await _repository.deleteTask(deleteTask);
      getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> removeTask(Tasks task) async {
    try {
      await _repository.removeTask(task);
      getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateTask(Tasks task) async {
    try {
      final isCompleted = !task.isCompleted;
      final updatedTask = task.copyWith(isCompleted: isCompleted);
      await _repository.updateTask(updatedTask);
      getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> pinTask(Tasks task) async {
    try {
      final isPinned = !task.isPinned;
      final pinTask = task.copyWith(isPinned: isPinned);
      await _repository.pinTask(pinTask);
      getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> editTask(Tasks task) async {
    try {
      await _repository.editTask(task);
      getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Tasks? getTaskById(String? id) {
    if (id == null) return null;

    try {
      final taskId = int.parse(id);

      return state.tasks.firstWhere((task) => task.id == taskId);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  void getTasks() async {
    try {
      final tasks = await _repository.getAllTasks();
      state = state.copyWith(tasks: tasks);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
