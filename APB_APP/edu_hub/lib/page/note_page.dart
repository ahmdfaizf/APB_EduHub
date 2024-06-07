import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_hub/constant/colors.dart';
import 'package:edu_hub/services/firestore_note.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController textController = TextEditingController();
  final FirestoreNoteServices firestoreService = FirestoreNoteServices();

  void openNoteBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              firestoreService.addNote(textController.text);
              textController.clear();
              Navigator.pop(context);
            },
            child: const Text("add note"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNoteBox(context),
        backgroundColor: AppPalet.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getNoteStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> noteList = snapshot.data!.docs;

              return ListView.builder(
                itemCount: noteList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = noteList[index];

                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String noteText = data['note'];

                  return ListTile(
                    title: Text(noteText),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Tambahkan aksi untuk tombol settings
                          },
                          icon: const Icon(Icons.settings),
                        ),
                        IconButton(
                          onPressed: () {
                            // Tambahkan aksi untuk tombol delete
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}