// lib/widgets/task_item.dart
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Text(
        task.title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          decoration: task.isDone
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          color: task.isDone ? Colors.grey : Colors.black,
        ),
      ),
      subtitle: task.description.isNotEmpty
          ? Text(
              task.description,
              style: TextStyle(
                color: task.isDone ? Colors.grey : Colors.black87,
              ),
            )
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pill-style toggle (Completed / Pending)
          InkWell(
            onTap: () {
              Provider.of<TaskProvider>(
                context,
                listen: false,
              ).toggleTask(index);
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: task.isDone
                    ? Colors.green.shade100
                    : Colors.orange.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                task.isDone ? "Completed" : "Pending",
                style: TextStyle(
                  color: task.isDone ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Delete button with confirmation dialog
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            tooltip: 'Delete task',
            onPressed: () async {
              final confirmed =
                  await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Delete task'),
                      content: Text(
                        'Are you sure you want to delete "${task.title}"?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(false),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          onPressed: () => Navigator.of(ctx).pop(true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  ) ??
                  false;

              if (confirmed) {
                Provider.of<TaskProvider>(
                  context,
                  listen: false,
                ).deleteTask(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Deleted "${task.title}"')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
