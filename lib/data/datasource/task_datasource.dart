import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/utils/utils.dart';

class TaskDatasource {
  static final TaskDatasource _instance = TaskDatasource._();
  factory TaskDatasource() => _instance;

  TaskDatasource._() {
    _initDB();
  }

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DBKeys.dbName);
    return openDatabase(
      path, 
      version: 1, 
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
      CREATE TABLE ${DBKeys.dbTable} (
        ${DBKeys.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DBKeys.titleComlumn} TEXT,
        ${DBKeys.noteComlumn} TEXT,
        ${DBKeys.timeComlumn} TEXT,
        ${DBKeys.dateComlumn} TEXT,
        ${DBKeys.categoryComlumn} TEXT,
        ${DBKeys.isCompletedComlumn} INTEGER,
        ${DBKeys.isPinnedComlumn} INTEGER,
        ${DBKeys.isDeletedColumn} INTEGER
      )
      ''');
    } catch (e) {
        print("Error creating table: $e");
      rethrow;
    }
  }

  Future<int> addTask(Tasks task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.insert(DBKeys.dbTable, task.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<int> deleteTask(Tasks task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.update(
        DBKeys.dbTable, 
        {DBKeys.isDeletedColumn: task.isDeleted ? 1 : 0},
        where: '${DBKeys.idColumn} = ?',
        whereArgs: [task.id]
        );
    });
  }

  Future<int> updateTask(Tasks task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.update(DBKeys.dbTable, task.toJson(),
          where: 'id =?', whereArgs: [task.id]);
    });
  }

  Future<int> removeTask(Tasks task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.delete(
        DBKeys.dbTable, 
        where: 'id =?', 
        whereArgs: [task.id]);
    });
  }
  
  Future<int> pinTask(Tasks task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.update(
        DBKeys.dbTable,
        {DBKeys.isPinnedComlumn: task.isPinned ? 1 : 0},
        where: '${DBKeys.idColumn} = ?',
        whereArgs: [task.id],
      );
    });
  }

  Future<List<Tasks>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> data =
        await db.query(
          DBKeys.dbTable, 
          orderBy: "id DESC"
        );

    return List.generate(
      data.length, 
      (index) => Tasks.fromJson(data[index])
    );
  }
}
