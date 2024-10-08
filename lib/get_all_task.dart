import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
              context,
              MaterialPageRoute(
                  builder: (context) => AddTaskView(
                        model: TaskModel(),
                        isUpdateMode: false,
                      )));
        },
        child: const Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: TaskServices().getAllTasks( FirebaseAuth.instance.currentUser!.uid.toString()),
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CupertinoSwitch(
                          value: taskList[i].isCompleted!,
                          onChanged: (val) {
                            if (taskList[i].isCompleted == false) {
                              TaskServices().markTaskAsComplete(
                                  taskList[i].docId.toString());
                            }
                          }),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddTaskView(
                                        model: taskList[i],
                                        isUpdateMode: true)));
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            log(taskList[i].docId.toString());
                            TaskServices()
                                .deleteTask(taskList[i].docId.toString());
                          },
                          icon: Icon(Icons.delete))
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
