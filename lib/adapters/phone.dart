import 'package:hive_flutter/hive_flutter.dart';


part 'phone.g.dart';

@HiveType(typeId: 2)
class Phone{
  @HiveField(0)
  final num phone;

  Phone(this.phone);
}