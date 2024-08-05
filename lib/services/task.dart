import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:usman_todo/models/task.dart';

class TaskServices {
  ///Create Task
  Future createTask(TaskModel model) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('taskCollection').doc();

    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(docRef.id.toString())
        .set(model.toJson(docRef.id));
  }

  ///Get All Tasks
  Stream<List<TaskModel>> getAllTasks(String userID) {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('userID', isEqualTo: userID)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => TaskModel.fromJson(e.data())).toList());
  }

  ///Update Tasks
  Future updateTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .update({'title': model.title, 'description': model.description});
  }

  ///Delete Tasks
  Future deleteTask(String taskID) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .delete();
  }

  ///Mark Task as Complete
  Future markTaskAsComplete(String taskID) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .update({'isCompleted': true});
  }

  ///Get InCompleted Tasks
  Stream<List<TaskModel>> getInCompletedTasks() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map((taskList) => taskList.docs
            .map((singleTask) => TaskModel.fromJson(singleTask.data()))
            .toList());
  }

  ///Get Completed Tasks
  Stream<List<TaskModel>> getCompletedTasks() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map((taskList) => taskList.docs
            .map((singleTask) => TaskModel.fromJson(singleTask.data()))
            .toList());
  }
}
