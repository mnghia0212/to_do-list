import 'package:flutter/material.dart';
import 'package:todo_app/utils/utils.dart';

@immutable
class DBKeys {
  const DBKeys._();
  static const String dbName = "tasks.db";
  static const String dbTable = "tasks";
  static const String idColumn = TaskKeys.id;
  static const String titleComlumn = TaskKeys.title;
  static const String noteComlumn = TaskKeys.note;
  static const String timeComlumn = TaskKeys.time;
  static const String dateComlumn = TaskKeys.date;
  static const String categoryComlumn = TaskKeys.category;
  static const String isCompletedComlumn = TaskKeys.isCompleted;

}
