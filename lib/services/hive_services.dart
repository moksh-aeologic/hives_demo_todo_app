import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hives_demo_todo_app/adapters/appoinments.dart';
import 'package:intl/intl.dart';

import '../adapters/phone.dart';
import '../adapters/task.dart';
import '../adapters/todo.dart';



class DatabaseClient {
	static const String _phoneBoxName = 'phone';
	static const String _taskBoxName = 'tasks';
	static const String _todoBoxName = 'todo';
  static const String _credsBoxName = 'creds';
  static const String _appoinmentBoxName = 'appoinment';

  DatabaseClient._();
  static final DatabaseClient provider = DatabaseClient._();




  Future<void> initialize() async {
		await Hive.initFlutter();
		Hive.registerAdapter(TaskAdapter());
		Hive.registerAdapter(PhoneAdapter());
		Hive.registerAdapter(TodoAdapter());
		Hive.registerAdapter(AppoinmentAdapter());
	}
  
	Future<Box<String>> get credsBox async => Hive.isBoxOpen(_credsBoxName) ?
		Hive.box<String>(_credsBoxName) : 
		await Hive.openBox<String>(_credsBoxName);
  
	Future<Box<Task>> get taskBox async => Hive.isBoxOpen(_taskBoxName) ?
		Hive.box<Task>(_taskBoxName) : 
		await Hive.openBox<Task>(_taskBoxName);

	Future<Box<Todo>> get todoBox async => Hive.isBoxOpen(_todoBoxName) ?
		Hive.box<Todo>(_todoBoxName) : 
		await Hive.openBox<Todo>(_todoBoxName);

	Future<Box<PhoneAdapter>> get phoneBox async => Hive.isBoxOpen(_phoneBoxName) ?
		Hive.box<PhoneAdapter>(_phoneBoxName) : 
		await Hive.openBox<PhoneAdapter>(_phoneBoxName);
  
  	Future<Box<Appoinment>> get appoinmentBox async => Hive.isBoxOpen(_appoinmentBoxName) ?
		Hive.box<Appoinment>(_appoinmentBoxName) : 
		await Hive.openBox<Appoinment>(_appoinmentBoxName);

  	Future<Map<String, String>?> getUsernameAndPass() async {
		Box<String> box = await credsBox;

		String? username = box.get('username');
		String? pass = box.get('password');

		return username != null && pass != null ? {
			'username': username,
			'password': pass
		} : null;
	}

	Future<void> storeUsernameAndPass(String username, String password) async {
		Box<String> box = await credsBox;

		await box.put('username', username);
		await box.put('password', password);
	}

	Future<void> addAllTask(List<Task> patients) async {
		Box<Task>? box = await taskBox;
		await box.addAll(patients);
	}

	Future<List<Task>> getTasks() async {
		Box<Task> box = await taskBox;
		return box.values.toList();
	}

	Future<void> clearTasks() async {
		Box<Task> box = await taskBox;
		await box.clear();
	}

	Future<void> addTodo(Todo todo) async {
		Box<Todo> box = await todoBox;
		await box.put(todo.id, todo);
	}

	Future<void> updateTodo(Todo todo) async {
		Box<Todo> box = await todoBox;
		await box.put(todo.id, todo);
	}

	Future<void> deleteTodo(Todo todo) async {
		Box<Todo> box = await todoBox;
		await box.delete(todo.id);
	}

	Future<List<Todo>> getAllTodos() async {
		Box<Todo> box = await todoBox;
		return box.values.toList();
	}

	Future<Todo?> getTodoById(String id) async {
		Box<Todo> box = await todoBox;
		return box.get(id);
	}

	Future<void> addAllAppoinment(List<Appoinment> appoinment) async {
		Box<Appoinment>? box = await appoinmentBox;
		await box.addAll(appoinment);
	}

	Future<void> addAppoinment(Appoinment appoinment) async {
    try {
  		Box<Appoinment> box = await appoinmentBox;
		  await box.put(appoinment.id, appoinment);
    } catch (e) {
      print("error is $e");
    }
	}

	Future<void> updateAppoinment(Appoinment appoinment) async {
		Box<Appoinment> box = await appoinmentBox;
		await box.put(appoinment.id, appoinment);
	}

	Future<void> deleteAppoinment(Appoinment appoinment) async {
		Box<Appoinment> box = await appoinmentBox;
		await box.delete(appoinment.id);
	}

	Future<List<Appoinment>> getAllAppoinment() async {
		Box<Appoinment> box = await appoinmentBox;
		return box.values.toList();
	}

  Future<List<Appoinment>> getAppoinmentsByDate(DateTime date) async {
		Box<Appoinment> box = await appoinmentBox;
		var list =  box.values.toList();
    List<Appoinment> appoinmentList = [];
    String formatTodaysDate = DateFormat('yyyy-MM-dd').format(date);

    for (var element in list) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(element.date);

      if (formattedDate==formatTodaysDate) {
        appoinmentList.add(element);
      }
    }
    return appoinmentList;
	}
}