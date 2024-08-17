// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:todo_app/utils/utils.dart';

class Tasks extends Equatable {
  final int? id;
  final String title;
  final String note;
  final String time;
  final String date;
  final bool isCompleted;
  final bool isPinned;
  final bool isDeleted;
  final TaskCategories category;

  const Tasks(
      {this.id,
      required this.title,
      required this.note,
      required this.time,
      required this.date,
      required this.isCompleted,
      required this.isPinned,
      required this.isDeleted,
      required this.category
  });

  @override
  List<Object> get props {
    return [
      id!,
      title,
      note,
      time,
      date,
      isCompleted,
      isPinned,
      isDeleted
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      TaskKeys.id: id,
      TaskKeys.title: title,
      TaskKeys.note: note,
      TaskKeys.time: time,
      TaskKeys.date: date,
      TaskKeys.isCompleted: isCompleted ? 1 : 0,
      TaskKeys.isPinned: isPinned ? 1 : 0,
      TaskKeys.isDeleted: isDeleted ? 1 : 0,
      TaskKeys.category: category.name,
    };
  }

  factory Tasks.fromJson(Map<String, dynamic> map) {
    return Tasks(
      id: map[TaskKeys.id],
      title: map[TaskKeys.title],
      note: map[TaskKeys.note],
      time: map[TaskKeys.time],
      date: map[TaskKeys.date],
      isCompleted: map[TaskKeys.isCompleted] == 1 ? true : false,
      isPinned: map[TaskKeys.isPinned] == 1 ? true : false,
      isDeleted: map[TaskKeys.isDeleted] == 1 ? true : false,
      category: TaskCategories.stringToCategory(map[TaskKeys.category]),
    );
  }

  Tasks copyWith({
    int? id,
    String? title,
    String? note,
    String? time,
    String? date,
    bool? isCompleted,
    bool? isPinned,
    bool? isDeleted,
    TaskCategories? category,
  }) {
    return Tasks(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      time: time ?? this.time,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
      isPinned: isPinned ?? this.isPinned,
      isDeleted: isDeleted ?? this.isDeleted,
      category: category ?? this.category,
    );
  }
}
