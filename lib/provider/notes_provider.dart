import 'package:flutter/material.dart';
import 'package:todo_isar/model/note.dart';

class NotesProvider extends ChangeNotifier {
  final List<Note> currentNotes = [];
}
