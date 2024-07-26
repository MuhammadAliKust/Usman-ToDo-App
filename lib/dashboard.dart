import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usman_todo/get_all_task.dart';
import 'package:usman_todo/services/task.dart';

import 'models/task.dart';

class DashBoardView extends StatelessWidget {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: StreamProvider.value(
          value: TaskServices().getInCompletedTasks(),
          initialData: [TaskModel()],
          builder: (context, child) {
            List<TaskModel> inCompletedTaskList =
                context.watch<List<TaskModel>>();
            return StreamProvider.value(
                value: TaskServices().getCompletedTasks(),
                initialData: [TaskModel()],
                builder: (context, child) {
                  List<TaskModel> completedTaskList =
                      context.watch<List<TaskModel>>();
                  return StreamProvider.value(
                      value: TaskServices().getAllTasks(),
                      initialData: [TaskModel()],
                      builder: (context, child) {
                        List<TaskModel> taskList =
                            context.watch<List<TaskModel>>();
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GetAllTaskView()));
                              },
                              child: Container(
                                height: 100,
                                color: Colors.blue,
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Total Tasks: ${taskList.length.toString()}",
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 100,
                              color: Colors.green,
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                "Completed Tasks: ${completedTaskList.length.toString()}",
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 100,
                              color: Colors.orange,
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                "InCompleted Tasks: ${inCompletedTaskList.length.toString()}",
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          ],
                        );
                      });
                });
          }),
    );
  }
}
