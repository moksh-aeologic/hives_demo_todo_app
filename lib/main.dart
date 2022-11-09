import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hives_demo_todo_app/services/hive_services.dart';
import '../task.dart';

void main() async {
  await hiveServices.hiveInitialization();
  hiveServices.registerAdapter(TaskAdapter());
  await hiveServices.openHiveBox<Task>('todo_box');
  runApp(
    MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color(0xff0D3257)),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 late Box<Task> tasksBox;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tasksBox = Hive.box('todo_box');
  }

  void onAddTask() {
    if (_textEditingController.text.isNotEmpty) {
      final newTask = Task(_textEditingController.text, false);
      hiveServices.addData(tasksBox, newTask);
      // tasksBox?.add(newTask);
      Navigator.pop(context);
      _textEditingController.clear();
      return;
    }
  }

  void onUpdateTask(int index, Task task) {
    hiveServices.editData(tasksBox, index, Task(task.title, !task.completed));
    return;
    // tasksBox?.putAt(index, Task(task.title, !task.completed));
  }

  void onDeleteTask(int index)async {
   await hiveServices.deleteData(tasksBox, index);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: ValueListenableBuilder(
        valueListenable: tasksBox.listenable(),
        builder: (context, value, child) {
          if (tasksBox.length > 0) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final task = tasksBox.get(index);

                return ListTile(
                  title: Text(task!.title),
                  leading: Checkbox(
                      activeColor: const Color(0x800d3257),
                      value: task.completed,
                      onChanged: (bool? value) => onUpdateTask(index, task)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onDeleteTask(index),
                  ),
                );
              },
              itemCount: tasksBox.length,
              separatorBuilder: (context, index) => const Divider(),
            );
          } else {
            return EmptyList();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff0D3257),
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Add New Task'),
              content: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(hintText: "Enter task"),
                autofocus: true,
              ),
              actions: [
                TextButton(
                    onPressed: () => onAddTask(), child: const Text('SAVE'))
              ],
            );
          },
        ),
      ),
    );
  }
}

class EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: const Icon(
              Icons.inbox_outlined,
              size: 30.0,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 4.0),
            child: const Text(
              "Don't have any tasks",
              style: TextStyle(fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }
}
