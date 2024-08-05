import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:usman_todo/get_all_task.dart';
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
  bool isLoading = false;

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
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
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
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Description cannot be empty.")));
                    return;
                  }

                  try {
                    isLoading = true;
                    setState(() {});
                    if (widget.isUpdateMode) {
                      await TaskServices()
                          .updateTask(TaskModel(
                              title: titleController.text,
                              description: descriptionController.text,
                              docId: widget.model.docId.toString()))
                          .then((value) {
                        isLoading = false;
                        setState(() {});
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content:
                                    Text('Task has been updated successfully'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GetAllTaskView()));
                                      },
                                      child: Text("Okay"))
                                ],
                              );
                            });
                      });
                    } else {
                      await TaskServices()
                          .createTask(TaskModel(
                              title: titleController.text,
                              description: descriptionController.text,
                              isCompleted: false,
                              userID:  FirebaseAuth.instance.currentUser!.uid.toString(),
                              createdAt: DateTime.now().millisecondsSinceEpoch))
                          .then((value) {
                        isLoading = false;
                        setState(() {});
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content:
                                    Text('Task has been added successfully'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GetAllTaskView()));
                                      },
                                      child: Text("Okay"))
                                ],
                              );
                            });
                      });
                    }
                  } catch (e) {
                    isLoading = false;
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Something went wrong.")));
                  }
                },
                child: Text(widget.isUpdateMode == true
                    ? "Update Task"
                    : "Create Task"))
          ],
        ),
      ),
    );
  }
}
