import 'package:todo_app/data/data.dart';

class TaskRepositoryImpl implements TaskRepositories {
  final TaskDatasource _datasource;
  TaskRepositoryImpl(this._datasource);

  @override
  Future<void> createTask(Tasks task) async {
    try {
      await _datasource.addTask(task);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> deleteTask(Tasks task) async {
    try {
      await _datasource.deleteTask(task);
    } catch (e) {
      throw '$e';
    }
  }
  
  @override
  Future<void> updateTask(Tasks task) async {
    try {
      await _datasource.updateTask(task);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> pinTask(Tasks task) async {
    try {
      await _datasource.pinTask(task);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<List<Tasks>> getAllTasks() async {
    try {
      return await _datasource.getAllTasks();
    } catch (e) {
      throw '$e';
    }
  }
}