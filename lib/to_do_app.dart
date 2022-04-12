import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/adapters/todo_adapter.dart';

import 'package:to_do_app/empty_list.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final TextEditingController _textFieldEditingController =
      TextEditingController();
  late Box<Todo> taskBox;
  @override
  void initState() {
    super.initState();
    taskBox = Hive.box('todo_box');
  }

  void _addingTask() {
    if (_textFieldEditingController.text.isNotEmpty) {
      final newTask = Todo(_textFieldEditingController.text, false);
      taskBox.add(newTask);

      Navigator.of(context).pop();
      _textFieldEditingController.clear();
      return;
    }
  }

  void _deleteTask(int index) {
    taskBox.deleteAt(index);
    return;
  }

  void checkTickBox(int index, Todo todo) {
    taskBox.putAt(
      index,
      Todo(todo.title, todo.completed),
    );
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task manager'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: taskBox.listenable(),
        builder: (context, value, child) {
          if (taskBox.length > 0) {
            return ListView.builder(
              itemBuilder: (context, index) {
                Todo? task = taskBox.getAt(index);
                return ListTile(
                  title: Text(
                    task!.title.toString(),
                  ),
                  trailing: IconButton(
                    onPressed: () => _deleteTask(index),
                    icon: const Icon(Icons.delete),
                  ),
                  leading: Checkbox(
                    value: task.completed,
                    onChanged: (value) => checkTickBox(
                      index,
                      Todo(task.title, value),
                    ),
                  ),
                );
              },
              itemCount: taskBox.length,
            );
          } else {
            return const EmptyList();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Add a task'),
              content: TextFormField(
                controller: _textFieldEditingController,
                decoration: const InputDecoration(
                  hintText: 'Add something',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Nothing added';
                  }
                  return null;
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => _addingTask(),
                  child: const Text('Save'),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
