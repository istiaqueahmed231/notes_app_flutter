import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_self/Providers/note_provider.dart'; // Make sure this matches Homepage exactly
import 'package:todo_self/Views//AddNotePage.dart';
import 'package:todo_self/Views//NotePage.dart';

import 'package:todo_self/Views/EditNotePage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // String title = ;
  // String subtitle = "Subtitle about NIGGAAA note";

  @override
  Widget build(BuildContext context) {
    void _showDeleteDialog(BuildContext context, NoteProvider provider, int id) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Delete Note?"),
          content: const Text("This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                provider.deleteNote(id);
                Navigator.pop(context);
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    }
    final noteProvider = Provider.of<NoteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Notes"),
        backgroundColor: Colors.greenAccent,

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => addNotepage()),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: noteProvider.isLoading
          ? Center(child: const CircularProgressIndicator())
          : Padding(
              padding: EdgeInsetsGeometry.all(8),
              child: Card(
                margin: const EdgeInsetsGeometry.all(5),
                child: ListView.separated(
                  padding: const EdgeInsetsGeometry.all(2),
                  itemCount: noteProvider.notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(noteProvider.notes[index].title),
                      // onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) =>
                      //           notePAge(subtitle: subtitle, title: title),
                      //     ),
                      //   );
                      // },
                      minVerticalPadding: 5,
                      leading: const Icon(Icons.person_3_rounded),
                      dense: true,
                      trailing: Row( // Using Row instead of Column for better spacing
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // UPDATE ICON
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditNotePage(note: noteProvider.notes[index]),
                                ),
                              );
                            },
                          ),
                          // DELETE ICON
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Simple confirmation before deleting
                              _showDeleteDialog(context, noteProvider, noteProvider.notes[index].id!);
                            },
                          ),
                        ],
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(15),
                        ),
                        side: BorderSide(
                          color: Colors.black87,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                ),
              ),
            ),
    );
  }
}
