import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/note.dart';
import '../screens/add_task_screen.dart';
import '../screens/add_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  List<Note> notes = [];

  void _addNewTask() async {
    final Task? newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );

    if (newTask != null) {
      setState(() {
        tasks.add(newTask);
      });
    }
  }

  void _addNewNote() async {
    final Note? newNote = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNoteScreen()),
    );

    if (newNote != null) {
      setState(() {
        notes.add(newNote);
      });
    }
  }

  void _showAddOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          height: 150,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _addNewTask();
                },
                child: const Text('Adicionar Tarefa'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _addNewNote();
                },
                child: const Text('Adicionar Nota'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _editTask(int index) async {
    final Task? editedTask = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddTaskScreen(task: tasks[index])),
    );

    if (editedTask != null) {
      setState(() {
        tasks[index] = editedTask;
      });
    } else {
      setState(() {
        tasks.removeAt(index);
      });
    }
  }

  void _editNote(int index) async {
    final Note? editedNote = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddNoteScreen(note: notes[index])),
    );

    if (editedNote != null) {
      setState(() {
        notes[index] = editedNote;
      });
    }
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  void _toggleTaskCompletion(int index, bool isCompleted) {
    setState(() {
      tasks[index].isCompleted = isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> combinedList = [];

    for (int i = 0; i < tasks.length; i++) {
      final task = tasks[i];
      combinedList.add(Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: (bool? value) {
              _toggleTaskCompletion(i, value ?? false);
            },
          ),
          title: Text(task.title),
          subtitle: Text(task.description),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editTask(i),
          ),
          onLongPress: () => _deleteTask(i),
        ),
      ));
    }

    for (int i = 0; i < notes.length; i++) {
      final note = notes[i];
      combinedList.add(Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          title: Text(note.title),
          subtitle: Text(note.description),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editNote(i),
          ),
          onLongPress: () => _deleteNote(i),
        ),
      ));
    }

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('NoteApp - Notas e Tarefas'),
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: combinedList.isEmpty
              ? const Center(
                  child: Text('Nenhuma tarefa ou nota adicionada ainda'))
              : ListView(children: combinedList),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddOptions,
        backgroundColor: Colors.blue[800],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
