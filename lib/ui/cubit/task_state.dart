import 'package:equatable/equatable.dart';
import 'package:todo_isar/model/task.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

// states of tasks

class TaskInitial extends TaskState {}

// loading state

class TaskLoading extends TaskState {}

// task loaded state

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  TaskLoaded(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

// task error state

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);

  @override
  List<Object?> get props => [message];
}
