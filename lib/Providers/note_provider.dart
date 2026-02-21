import 'package:flutter/material.dart';
import '../Models/Note.dart';
import '../repositories/note_repository.dart';

class NoteProvider extends ChangeNotifier {
  final NoteRepository _repository = NoteRepository();

  List<Note> _notes = [];
  bool _isLoading = false;

  // Getters to access data from the UI
  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;

  // 1. Fetch all notes
  Future<void> loadNotes() async {
    _isLoading = true;
    notifyListeners(); // Tell UI to show a loading spinner

    _notes = await _repository.fetchAllNotes();

    _isLoading = false;
    notifyListeners();
    // Tell UI to hide spinner and show list
    print("notes fetched");
  }

  // 2. Add a note
  Future<void> addNote(Note note) async {
    bool success = await _repository.addNote(note);
    if (success) {
      await loadNotes();
      print("note saved");// Refresh the list automatically
    }
    //await loadNotes();
    }

    // 3. Delete a note
    Future<void> deleteNote(int id) async {
      bool success = await _repository.removeNote(id);
      if (success) {
        _notes.removeWhere((note) => note.id == id);
        notifyListeners(); // Update UI immediately
      }
    }

  Future<void> updateNote(Note note) async {
    // 1. Tell the repository to update the database
    bool success = await _repository.updateNote(note);

    if (success) {
      // 2. Refresh the local list so the UI shows the changes
      await loadNotes();
      // loadNotes calls notifyListeners(), so the Homepage will rebuild automatically
    }
  }
  }
