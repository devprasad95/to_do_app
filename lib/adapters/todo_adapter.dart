import 'package:hive/hive.dart';

part 'todo_adapter.g.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  final String? title;

  @HiveField(1)
  late final bool? completed;

  Todo(this.title, this.completed);
}
