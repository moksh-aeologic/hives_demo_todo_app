import 'package:hive_flutter/hive_flutter.dart';


part 'appoinments.g.dart';

@HiveType(typeId: 1)
class Appoinment{
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final DateTime creationDate;

  @HiveField(5)
  final int repeat;

  Appoinment(this.id, this.title, this.creationDate, this.date, this.description, this.repeat);
}