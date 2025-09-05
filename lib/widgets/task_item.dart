import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class TaskItem extends StatelessWidget {
  final int index;
  const TaskItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<TaskProvider>(context).tasks[index];

    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Text(task.description),
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (_) => Provider.of<TaskProvider>(context, listen: false).toggleTask(index),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => Provider.of<TaskProvider>(context, listen: false).deleteTask(index),
      ),
    );
  }
}
