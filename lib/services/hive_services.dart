import 'package:hive_flutter/hive_flutter.dart';

class HiveServices {
  hiveInitialization() async {
    await Hive.initFlutter();
  }

  void registerAdapter<T>(TypeAdapter<T> adapter) {
    return Hive.registerAdapter(adapter);
  }

  Future<Box<E>> openHiveBox<E>(String boxName) async {
    return await Hive.openBox(boxName);
  }

  Future<int> addData(Box? boxName, dynamic value) async {
    return await boxName!.add(value);
  }

  editData(Box? boxName, int index, dynamic value) async {
    return await boxName?.putAt(index, value);
  }

  deleteData(Box? boxName,int index) async {
    return await boxName?.deleteAt(index);
  }
  
  closeBox(Box? boxName,int index) async {
    return await boxName?.close();
  }

  getData(Box? boxName,dynamic key) async {
    return await boxName?.get(key);
  }
  
}

HiveServices hiveServices = HiveServices();
