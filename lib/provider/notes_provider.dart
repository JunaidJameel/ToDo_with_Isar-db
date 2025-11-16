import 'package:flutter/material.dart';
import 'package:todo_isar/model/note.dart';
import 'package:todo_isar/service/notes_service.dart';

class NotesProvider extends ChangeNotifier {
  final noteService = NotesService();
  final List<Note> currentNotes = [];

  Future<void> createNote(String task) async {
    await noteService.createNote(task);
    final tasks = await noteService.fetchNotes();

    currentNotes.clear();
    currentNotes.addAll(tasks);
    notifyListeners();
  }

  Future<void> fetchNotes() async {
    final tasks = await noteService.fetchNotes();
    currentNotes.clear();
    currentNotes.addAll(tasks);
    notifyListeners();
  }
}
