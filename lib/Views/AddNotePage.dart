import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_self/Models/Note.dart'; // Ensure path is correct
import 'package:todo_self/Providers/note_provider.dart';
import 'package:intl/intl.dart'; // Run 'flutter pub add intl' for date formatting

class addNotepage extends StatefulWidget {
  final Note? note; // Add this
  const addNotepage({super.key, this.note}); // Update this


  @override
  State<addNotepage> createState() => _addNotepageState();
}

class _addNotepageState extends State<addNotepage> {
  // 1. Create Controllers to grab text from fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // 2. Create a GlobalKey for the Form to trigger validation
  final _formKey = GlobalKey<FormState>();

  String? text_validator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field cannot be empty";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a New Note"),
        backgroundColor: Colors.greenAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // 3. Wrap inputs in a Form
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController, // Assign controller
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
                validator: text_validator,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _descriptionController, // Assign controller
                maxLines: 5, // Make note area larger
                decoration: const InputDecoration(
                  labelText: "Note",
                  border: OutlineInputBorder(),
                ),
                validator: text_validator,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _saveNote(context), // Call save function
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                    child: const Text("Save"),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context), // Just go back
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                    child: const Text("Cancel"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // 4. Logic to Save
  void _saveNote(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Create Note Object
      Note newNote = Note(
        _titleController.text,
        _descriptionController.text,
        DateFormat.yMMMd().format(DateTime.now()), // Formatted date
      );

      // Call Provider (listen: false because we are in a function)
      Provider.of<NoteProvider>(context, listen: false).addNote(newNote);

      // Return to Homepage
      Navigator.pop(context);
    }
  }
}