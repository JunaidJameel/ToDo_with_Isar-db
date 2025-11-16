import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_isar/service/service_locator.dart';
import 'package:todo_isar/service/task_service.dart';
import 'package:todo_isar/ui/cubit/task_cubit.dart';
import 'package:todo_isar/ui/todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo Isar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => TasksCubit(TaskService()),
        child: const TodoScreen(),
      ),
    );
  }
}
