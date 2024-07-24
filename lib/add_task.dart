import 'package:flutter/material.dart';
import 'package:usman_todo/models/task.dart';
import 'package:usman_todo/services/task.dart';

class AddTaskView extends StatelessWidget {
  AddTaskView({super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
          ),
          TextField(
            controller: descriptionController,
          ),
          ElevatedButton(
              onPressed: () async {
                if (titleController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Title cannot be empty.")));
                  return;
                }
                if (descriptionController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Description cannot be empty.")));
                  return;
                }
                try {
                  await TaskServices().createTask(TaskModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      isCompleted: false,
                      createdAt: DateTime.now().millisecondsSinceEpoch));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Something went wrong.")));
                }
              },
              child: Text("Create Task"))
        ],
      ),
    );
  }
}
