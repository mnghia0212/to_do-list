import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("tasks.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE tasks (
        taskId $idType,
        taskName $textType
      )''');
  }

  Future<int> addTask(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('tasks', row);
  }

  Future<List<Map<String, dynamic>>> fetchTasks;() async {
    final db = await instance.database;
    return await db.query('tasks');
  }

  Future<int> deleteTask(int taskId) async {
    final db = await instance.database;
    return await db.delete('tasks', where: 'taskId = ?', whereArgs: [taskId]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
