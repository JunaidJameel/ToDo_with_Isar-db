import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_isar/model/note.dart';
import 'package:todo_isar/provider/notes_provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();

    context.read<NotesProvider>().fetchNotes();
  }

  final textController = TextEditingController();
  // create a task

  void createTask() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              actions: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.black,
                  onPressed: () {
                    context
                        .read<NotesProvider>()
                        .createNote(textController.text.trim());
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Create Task',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
              content: TextField(
                controller: textController,
                decoration:
                    const InputDecoration(hintText: 'Enter your task here'),
              ),
            ));
  }
  // update a task

  void updateTask(Note note) {
    textController.text = note.task;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              actions: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.black,
                  onPressed: () {
                    context
                        .read<NotesProvider>()
                        .createNote(textController.text.trim());
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Update Task',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
              content: TextField(
                focusNode: FocusNode()..requestFocus(),
                controller: textController,
                decoration:
                    const InputDecoration(hintText: 'Enter your task here'),
              ),
            ));
  }

  // delete a task
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          textController.clear();
          createTask();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: const Text(
          'ToDo with Isar DB',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, _) {
          final tasks = notesProvider.currentNotes;

          if (tasks.isEmpty) {
            return const Center(
              child: Text(
                'No Tasks Yet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.separated(
            itemBuilder: (_, index) {
              final task = tasks[index];
              return ListTile(
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => updateTask(task),
                      icon: const Icon(Icons.edit, color: Colors.blue),
                    ),
                    // IconButton(
                    //   onPressed: () => context
                    //       .read<NotesProvider>()
                    //       .noteService
                    //       .deleteNote(task.id),
                    //   icon: const Icon(Icons.delete, color: Colors.red),
                    // ),
                  ],
                ),
                title: Text(task.task),
              );
            },
            separatorBuilder: (_, index) => const Divider(),
            itemCount: tasks.length,
          );
        },
      ),
    );
  }
}
