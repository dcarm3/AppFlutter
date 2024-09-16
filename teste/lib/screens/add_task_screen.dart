import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/task.dart';
import '../services/notification_service.dart';
import '../utils/date_time_picker.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task; // Tarefa passada para edição (opcional)

  AddTaskScreen({this.task});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _notificationService.init(); // Inicializando notificações

    // Se estiver editando, preencher os campos com os dados da tarefa existente
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _selectedDate = widget.task!.alarmTime;
    }
  }

  // Função para selecionar data e hora
  Future<void> _selectDateTime() async {
    DateTime? picked = await pickDateTime(context);
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Função para salvar tarefa
  void _saveTask() {
    if (_titleController.text.isEmpty || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor, preencha o título e o horário do alarme!'),
      ));
      return;
    }

    Task newTask = Task(
      title: _titleController.text,
      description: _descriptionController.text,
      alarmTime: _selectedDate,
    );

    // Agendar notificação
    _notificationService.scheduleNotification(newTask.alarmTime!);

    // Retornar a nova ou editada tarefa para a tela anterior
    Navigator.pop(context, newTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Adicionar Tarefa' : 'Editar Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _selectDateTime,
              child: Text(_selectedDate == null
                  ? 'Escolher Alarme'
                  : 'Alarme: ${_selectedDate.toString()}'),
            ),
            SizedBox(height: 20),
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
