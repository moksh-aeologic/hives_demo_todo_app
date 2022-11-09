import 'package:flutter/material.dart';
import 'package:hives_demo_todo_app/services/hive_services.dart';
import 'adapters/task.dart';
import 'pages/appoinment_page.dart';

void main() async {
  await DatabaseClient.provider.initialize();
  await DatabaseClient.provider.appoinmentBox;
  runApp(
    MaterialApp(
      title: 'Appoinment App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color(0xff0D3257)),
      home: const AppoinmentPage(),
    ),
  );
}
