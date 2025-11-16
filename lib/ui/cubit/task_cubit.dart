import 'package:todo_isar/service/task_service.dart';
import 'package:todo_isar/ui/cubit/task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksCubit extends Cubit<TaskState> {
  final TaskService noteService;

  TasksCubit(this.noteService) : super(TaskInitial());

  Future<void> fetchTasks() async {
    try {
      emit(TaskLoading());
      final tasks = await noteService.fetchTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> createTask(String task) async {
    try {
      await noteService.createTask(task);
      await fetchTasks();
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> updateTask(int id, String updatedTask) async {
    try {
      await noteService.updateTask(id, updatedTask);
      await fetchTasks();
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await noteService.deleteTask(id);
      await fetchTasks();
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
