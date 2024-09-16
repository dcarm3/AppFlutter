import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/note.dart';
import '../screens/add_task_screen.dart';
import '../screens/add_note_screen.dart';
import '../widgets/task_note_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  List<Note> notes = [];

  void _addNewTask() async {
    final Task? newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskScreen()),
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
      MaterialPageRoute(builder: (context) => AddNoteScreen()),
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
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _addNewTask();
                },
                child: Text('Adicionar Tarefa'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _addNewNote();
                },
                child: Text('Adicionar Nota'),
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
    final combinedList = <Widget>[
      ...tasks.map((task) => Stack(
            children: [
              Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editTask(tasks.indexOf(task)),
                  ),
                  onLongPress: () => _deleteTask(tasks.indexOf(task)),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Checkbox(
                  value: task.isCompleted,
                  onChanged: (bool? value) {
                    _toggleTaskCompletion(tasks.indexOf(task), value ?? false);
                  },
                ),
              ),
            ],
          )),
      ...notes.map((note) => Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(note.title),
              subtitle: Text(note.description),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _editNote(notes.indexOf(note)),
              ),
              onLongPress: () => _deleteNote(notes.indexOf(note)),
            ),
          )),
    ];

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('NoteApp - Notas e Tarefas'),
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: combinedList.isEmpty
              ? Center(child: Text('Nenhuma tarefa ou nota adicionada ainda'))
              : ListView(children: combinedList),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddOptions,
        backgroundColor: Colors.blue[800],
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
