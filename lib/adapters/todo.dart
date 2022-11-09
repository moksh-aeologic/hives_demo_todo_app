import 'package:hive_flutter/hive_flutter.dart';


part 'todo.g.dart';

@HiveType(typeId: 4)
class Todo {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool completed;

  Todo(this.id, this.title, this.completed);
}