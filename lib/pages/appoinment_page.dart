import 'package:flutter/material.dart';
import 'package:hives_demo_todo_app/adapters/appoinments.dart';

import '../services/hive_services.dart';

class AppoinmentPage extends StatefulWidget {
  const AppoinmentPage({super.key});

  @override
  State<AppoinmentPage> createState() => _AppoinmentPageState();
}

class _AppoinmentPageState extends State<AppoinmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Appoinment page",
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              // final getYesterday =
              //     DateTime.now().subtract(const Duration(days: 1));
              Appoinment appoinment = Appoinment("3", "This is 3rd title",
                  DateTime.now(), DateTime.now(), "This is 3rd description", 4);
              await DatabaseClient.provider.addAppoinment(appoinment);
              print("Appoinment added");
            },
            child: const Text("Add data"),
          ),
          Expanded(
            child: FutureBuilder(
              future:
                  DatabaseClient.provider.getAppoinmentsByDate(DateTime.now()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Appoinment appoinment = snapshot.data[index];
                    return ListTile(
                      title: Text(appoinment.title),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
