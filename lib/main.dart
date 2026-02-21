import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Providers/note_provider.dart';
import 'Views/HomePage.dart';

void main() {
  runApp(
    // Wrap the WHOLE app here
    ChangeNotifierProvider(
      create: (context) => NoteProvider()..loadNotes(),
      child: const NotesApp(),
    ),
  );
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NotesApp",
      debugShowCheckedModeBanner: false,
      // Now Homepage will definitely be a "child" of the Provider
      home: const Homepage(),
    );
  }
}