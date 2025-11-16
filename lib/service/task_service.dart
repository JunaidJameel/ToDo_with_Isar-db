import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_isar/model/task.dart';

class TaskService {
  static late Isar isar;

// INITIALIZE - DB

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open([TaskSchema], directory: dir.path);
  }

// CREATE A task

  Future<void> createTask(String taskFromUser) async {
    final newTask = Task()..task = taskFromUser;

    // save to db

    await isar.writeTxn(() {
      return isar.tasks.put(newTask);
    });
  }

// READ A task

  Future<List<Task>> fetchTasks() async {
    return await isar.tasks.where().findAll();
  }

// UPDATE A task

  Future<void> updateTask(int id, String updatedTask) async {
    final existingTask = await isar.tasks.get(id);

    if (existingTask != null) {
      existingTask.task = updatedTask;
      await isar.writeTxn(() => isar.tasks.put(existingTask));
      await fetchTasks();
    }
  }

// DELETE A task

  Future<void> deleteTask(int id) async {
    await isar.writeTxn(() => isar.tasks.delete(id));
    await fetchTasks();
  }
}
