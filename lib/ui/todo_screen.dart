import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_isar/model/task.dart';
import 'package:todo_isar/ui/cubit/task_cubit.dart';
import 'package:todo_isar/ui/cubit/task_state.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TasksCubit>().fetchTasks();
  }

  final textController = TextEditingController();

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
              context.read<TasksCubit>().createTask(textController.text.trim());
              textController.clear();
              Navigator.pop(context);
            },
            child: const Text(
              'Create Task',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: 'Enter your task here'),
        ),
      ),
    );
  }

  void updateTask(Task note) {
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
              context.read<TasksCubit>().updateTask(
                    note.id,
                    textController.text.trim(),
                  );
              textController.clear();
              Navigator.pop(context);
            },
            child: const Text(
              'Update Task',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
        content: TextField(
          focusNode: FocusNode()..requestFocus(),
          controller: textController,
          decoration: const InputDecoration(hintText: 'Enter your task here'),
        ),
      ),
    );
  }

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
      body: BlocBuilder<TasksCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is TaskLoaded) {
            final tasks = state.tasks;

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
                      IconButton(
                        onPressed: () =>
                            context.read<TasksCubit>().deleteTask(task.id),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                  title: Text(task.task),
                );
              },
              separatorBuilder: (_, index) => const Divider(),
              itemCount: tasks.length,
            );
          }

          return const Center(
            child: Text(
              'No Tasks Yet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
