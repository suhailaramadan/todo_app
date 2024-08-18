import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/task_model.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();
  bool isDone = false;
  Future<void> getTasks() async {
    List<TaskModel> allTasks =
        await FirebaseFunctions.getAllTasksFromFirestore();
    tasks = allTasks
        .where((tasks) =>
            tasks.date.day == selectedDate.day &&
            tasks.date.month == selectedDate.month &&
            tasks.date.year == selectedDate.year)
        .toList();
    notifyListeners();
  }

  void changeSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void changeIconToText(bool isdone) {
    isDone = !isdone;
    notifyListeners();
  }
}
