import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/models/task.dart';

void main() {
  test('Task toggles completion status', () {
    final task = Task(title: "Test Task", description: "Test Desc");
    expect(task.isCompleted, false);

    task.toggleCompleted();
    expect(task.isCompleted, true);

    task.toggleCompleted();
    expect(task.isCompleted, false);
  });
}
