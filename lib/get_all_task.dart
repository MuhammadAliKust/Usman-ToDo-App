import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usman_todo/add_task.dart';
import 'package:usman_todo/models/task.dart';
import 'package:usman_todo/services/task.dart';

class GetAllTaskView extends StatelessWidget {
  const GetAllTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get All Tasks"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTaskView()));
        },
        child: const Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: TaskServices().getAllTasks(),
        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(taskList[i].title.toString()),
                  subtitle: Text(taskList[i].description.toString()),
                  leading: const Icon(Icons.task),
                  trailing: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.edit), Icon(Icons.delete)],
                  ),
                );
              });
        },
      ),
    );
  }


}
