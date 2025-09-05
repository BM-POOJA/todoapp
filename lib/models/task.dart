// lib/models/task.dart
class Task {
  final String title;
  final String description;
  bool isDone;

  Task({
    required this.title,
    this.description = '',
    this.isDone = false,
  });

  void toggleDone() {
    isDone = !isDone;
  }
}
