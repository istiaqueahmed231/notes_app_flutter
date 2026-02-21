//handles raw sqflite commands

import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/Note.dart';

class DbHelper {
  static DbHelper? _dbHelper;
  static Database? _database;

  String noteTable = 'note_table'; //table name
  String colId = 'id'; //id column
  String colTitle = 'title'; //title column
  String colDescription = 'description'; //description table

  String colDate = 'date'; //date column

  // Named constructor to create instance of DatabaseHelper
  DbHelper._createInstance();

  // Corrected Factory
  factory DbHelper() {
    _dbHelper ??= DbHelper._createInstance(); // Initialize only if null
    return _dbHelper!;
  }

  Future<Database> get database async {
    _database??= await initializeDB(); // Initialize only if null
    return _database!;
  }

  Future<Database> initializeDB() async {
    //directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'notes.db');

    //Open/create the database at a given path
    var notesDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
      '$colDescription TEXT, $colDate TEXT)',
    );
  }

  // Fetch Operation: Get all note objects from database
  //returns list of json
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

    //		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable);
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toJson());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateNote(Note note) async {
    var db = await this.database;
    var result = await db.update(noteTable, note.toJson(), where: '$colId = ?', whereArgs: [note.id]);
    return result;
    //returns 1, the update was successful.
    //returns 0, it means no note with that ID was found.
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
     return await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');

  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');
    //the database returns a list of maps that looks like this: [{COUNT (*): 5}]
    int result = Sqflite.firstIntValue(x)??0;
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Note>> getNoteList() async {

    var noteMapList = await getNoteMapList(); // Get 'Map List' from database
    int count = noteMapList.length;         // Count the number of map entries in db table

    List<Note> noteList = [];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromJson(noteMapList[i]));
    }

    return noteList;
  }

}
