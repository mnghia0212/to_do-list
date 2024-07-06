// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:todo_app/data/models/models.dart';

class TaskState extends Equatable {
  final List<Tasks> tasks;

  const TaskState(this.tasks);

  const TaskState.initial({this.tasks = const []});

  TaskState copyWith({
    List<Tasks>? tasks,
  }) {
    return TaskState(
      tasks ?? this.tasks,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
