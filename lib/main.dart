import 'package:flutter/material.dart';
import 'package:to_do_app/adapters/todo_adapter.dart';
import 'package:to_do_app/to_do_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('todo_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            accentColor: Colors.pink, primarySwatch: Colors.pink),
      ),
      home: const ToDoApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
