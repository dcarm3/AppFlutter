import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;
  final Function(int) onEditNote;

  NoteList({required this.notes, required this.onEditNote});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onEditNote(index),
          child: Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(notes[index].title),
              subtitle: Text(notes[index].description),
              trailing: Icon(Icons.edit),
            ),
          ),
        );
      },
    );
  }
}
