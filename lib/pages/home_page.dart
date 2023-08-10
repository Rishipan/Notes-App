import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/pages/add_new_note_page.dart';
import 'package:notes/provider/notes_provider.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        elevation: 1,
        centerTitle: true,
      ),
      body: SafeArea(
        child: (notesProvider.notes.length > 0)
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: notesProvider.notes.length,
                itemBuilder: (context, index) {
                  Note currentNote = notesProvider.notes[index];

                  return GestureDetector(
                    onTap: () {
                      // update
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => AddNewNotePage(
                                    isUpdate: true,
                                    note: currentNote,
                                  )));
                    },
                    onLongPress: () {
                      // delete
                      notesProvider.deleteNote(currentNote);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      // color: Colors.blue,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentNote.title!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            currentNote.content!,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade700,
                            ),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text("No notes yet"),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoDialogRoute(
                transitionDuration: const Duration(milliseconds: 500),
                builder: (context) => const AddNewNotePage(
                      isUpdate: false,
                    ),
                context: context),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
