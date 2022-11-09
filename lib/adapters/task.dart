import 'package:hive_flutter/hive_flutter.dart';


part 'task.g.dart';

@HiveType(typeId: 3)
class Task {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final bool completed;

  Task(this.title, this.completed);
}