import 'package:flutter/material.dart';
import 'package:usman_todo/models/task.dart';
import 'package:usman_todo/services/task.dart';

class AddTaskView extends StatefulWidget {
  final TaskModel model;
  final bool isUpdateMode;

  AddTaskView({super.key, required this.model, required this.isUpdateMode});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdateMode == true) {
      titleController = TextEditingController(text: widget.model.title);
      descriptionController =
          TextEditingController(text: widget.model.description);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdateMode ? "Update Task" : "Add Task"),
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
                  if (widget.isUpdateMode) {
                    await TaskServices().updateTask(TaskModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        docId: widget.model.docId.toString()));
                  } else {
                    await TaskServices().createTask(TaskModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        isCompleted: false,
                        createdAt: DateTime.now().millisecondsSinceEpoch));
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Something went wrong.")));
                }
              },
              child: Text(
                  widget.isUpdateMode == true ? "Update Task" : "Create Task"))
        ],
      ),
    );
  }
}
