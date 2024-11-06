// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../models/note.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;

  const AddNoteScreen({super.key, this.note});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
    }
  }

  void _saveNote() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Por favor, preencha o título!'),
      ));
      return;
    }

    Note newNote = Note(
      title: _titleController.text,
      description: _descriptionController.text,
    );

    Navigator.pop(context, newNote);
  }

  void _deleteNote() {
    Navigator.pop(context, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Adicionar Nota' : 'Editar Nota'),
        actions: [
          if (widget.note != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteNote,
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
            ElevatedButton(
              onPressed: _saveNote,
              child: Text(
                  widget.note == null ? 'Salvar Nota' : 'Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
