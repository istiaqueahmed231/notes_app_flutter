import '../Models/Note.dart';
import 'dart:async';
import '../Services/db_helper.dart';

class NoteRepository {
  final DbHelper _dbHelper = DbHelper();

  //to get all notes
  Future<List<Note>> fetchAllNotes() async {
    return await _dbHelper.getNoteList();
  }

  //to add a new notes
  Future<bool> addNote(Note note) async {
    int result = await _dbHelper.insertNote(note);
    return result > 0;
  }

  //to delete a note
  Future<bool> removeNote(int id) async {
    int result = await _dbHelper.deleteNote(id);
    return result > 0;
  }

  //to update a existing note
  Future<bool> updateNote(Note note) async {
    int result = await _dbHelper.updateNote(note);
    return result > 0;
  }
}
