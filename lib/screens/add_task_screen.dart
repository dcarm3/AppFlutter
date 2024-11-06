import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;

  const AddTaskScreen({super.key, this.task});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _isCompleted = widget.task!.isCompleted;
    }
  }

  void _saveTask() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Por favor, preencha o título!'),
      ));
      return;
    }

    Task newTask = Task(
      title: _titleController.text,
      description: _descriptionController.text,
      isCompleted: _isCompleted,
    );

    Navigator.pop(context, newTask);
  }

  void _deleteTask() {
    Navigator.pop(context, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Adicionar Tarefa' : 'Editar Tarefa'),
        actions: [
          if (widget.task != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteTask,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _isCompleted,
                  onChanged: (value) {
                    setState(() {
                      _isCompleted = value ?? false;
                    });
                  },
                ),
                const Text('Tarefa Concluída')
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text(
                  widget.task == null ? 'Salvar Tarefa' : 'Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
