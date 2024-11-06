import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(int) onEditTask;

  const TaskList({super.key, required this.tasks, required this.onEditTask});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onEditTask(index),
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(tasks[index].title),
              subtitle: Text(tasks[index].description),
              trailing: const Icon(Icons.edit),
            ),
          ),
        );
      },
    );
  }
}
