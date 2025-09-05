import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(String title, String description) {
    _tasks.add(Task(title: title, description: description));
    notifyListeners();
  }

  void toggleTask(int index) {
    _tasks[index].toggleCompleted();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}
