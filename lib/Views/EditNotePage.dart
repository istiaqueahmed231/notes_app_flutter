import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_self/Models/Note.dart';
import 'package:todo_self/Providers/note_provider.dart';

class EditNotePage extends StatefulWidget {
  final Note note; // The note we want to edit

  const EditNotePage({super.key, required this.note});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    // Pre-fill the controllers with existing data
    _titleController = TextEditingController(text: widget.note.title);
    _descriptionController = TextEditingController(text: widget.note.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _updateNote() {
    // 1. Update the existing note object with new values
    widget.note.title = _titleController.text;
    widget.note.description = _descriptionController.text;
    widget.note.date = DateTime.now().toString(); // Optional: update timestamp

    // 2. Call the provider to save to sqflite
    Provider.of<NoteProvider>(context, listen: false).updateNote(widget.note);

    // 3. Go back to Homepage
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: "Description", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateNote,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
              child: const Text("Save Changes"),
            )
          ],
        ),
      ),
    );
  }
}