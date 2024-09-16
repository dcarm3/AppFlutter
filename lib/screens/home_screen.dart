import 'package:flutter/material.dart';
import '../models/task.dart';
import '../screens/add_task_screen.dart';
import '../widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Minhas Tarefas'),
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: tasks.isEmpty
              ? Center(
                  child: Text(
                    'Nenhuma tarefa adicionada ainda',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                )
              : TaskList(tasks: tasks, onEditTask: _editTask),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTask,
        backgroundColor: Colors.blue[800],
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
