import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/note.dart';

class TaskNoteList extends StatelessWidget {
  final List<Task> tasks;
  final List<Note> notes;
  final Function(int, bool) onTaskStatusChanged;
  final Function(int) onEditTask;
  final Function(int) onEditNote;
  final Function(int) onDeleteTask;
  final Function(int) onDeleteNote;

  TaskNoteList({
    required this.tasks,
    required this.notes,
    required this.onTaskStatusChanged,
    required this.onEditTask,
    required this.onEditNote,
    required this.onDeleteTask,
    required this.onDeleteNote,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length + notes.length,
      itemBuilder: (context, index) {
        if (index < tasks.length) {
          final task = tasks[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Checkbox(
                    value: task.isCompleted,
                    onChanged: (bool? value) {
                      onTaskStatusChanged(index, value ?? false);
                    },
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(task.description),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => onEditTask(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => onDeleteTask(index),
                  ),
                ],
              ),
            ),
          );
        } else {
          final noteIndex = index - tasks.length;
          final note = notes[noteIndex];
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(note.description),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => onEditNote(noteIndex),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => onDeleteNote(noteIndex),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
