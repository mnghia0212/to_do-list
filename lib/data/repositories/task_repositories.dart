import 'package:todo_app/data/models/models.dart';

abstract class TaskRepositories {
  Future<void> createTask(Tasks task);
  Future<void> deleteTask(Tasks task);
  Future<void> removeTask(Tasks task);
  Future<void> updateTask(Tasks task);
  Future<void> editTask(Tasks task);
  Future<void> pinTask(Tasks task);
  Future<List<Tasks>> getAllTasks();
}
