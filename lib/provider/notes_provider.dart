import 'package:flutter/material.dart';
import 'package:todo_isar/model/note.dart';
import 'package:todo_isar/service/notes_service.dart';

class NotesProvider extends ChangeNotifier {
  final noteService = NotesService();
  final List<Note> currentNotes = [];

  Future<void> createNote(String task) async {
    await noteService.createNote(task);
    await fetchNotes();
  }

  Future<void> fetchNotes() async {
    final tasks = await noteService.fetchNotes();
    currentNotes.clear();
    currentNotes.addAll(tasks);
    notifyListeners();
  }

  Future<void> updateNote(int id, String updatedTask) async {
    await noteService.updateNote(id, updatedTask);
    await fetchNotes();
  }

  Future<void> deleteNote(int id) async {
    await noteService.deleteNote(id);
    await fetchNotes();
  }
}
