import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_isar/model/note.dart';

class NotesService {
  static late Isar isar;

// INITIALIZE - DB

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

// CREATE A NOTE

  Future<void> createNote(String taskFromUser) async {
    final newTask = Note()..task = taskFromUser;

    // save to db

    await isar.writeTxn(() {
      return isar.notes.put(newTask);
    });
  }

// READ A NOTE

  Future<List<Note>> fetchNotes() async {
    return await isar.notes.where().findAll();
  }

// UPDATE A NOTE

  Future<void> updateNote(int id, String updatedTask) async {
    final existingTask = await isar.notes.get(id);

    if (existingTask != null) {
      existingTask.task = updatedTask;
      await isar.writeTxn(() => isar.notes.put(existingTask));
      await fetchNotes();
    }
  }

// DELETE A NOTE

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
