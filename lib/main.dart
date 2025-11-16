import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_isar/provider/notes_provider.dart';
import 'package:todo_isar/service/notes_service.dart';
import 'package:todo_isar/ui/todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotesService.init();
  runApp(ChangeNotifierProvider(
    create: (_) => NotesProvider(),
    child: const MyApp(),
  ));
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
      home: const TodoScreen(),
    );
  }
}
