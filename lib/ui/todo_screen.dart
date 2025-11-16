import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
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
                  onPressed: createTask,
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

  // delete a task
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text(
          'ToDo with Isar DB',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        child: Text('Todo Screen'),
      ),
    );
  }
}
