
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

  void openNoteBox(BuildContext context, {String ? docIDs}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if(docIDs == null){
                firestoreService.addNote(textController.text);
              }else{
                firestoreService.updateNote(docIDs, textController.text);
              }
              textController.clear();
              Navigator.pop(context);
            },
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppPalet.primary),
              textStyle: MaterialStatePropertyAll(TextStyle(color: AppPalet.secondary))
            ),
            child: const Text("add", style: TextStyle(
              color: AppPalet.secondary
            ),)
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: AppPalet.primary,
        title: const Text("Notes", style:TextStyle(
          color: AppPalet.secondary,
          fontWeight: FontWeight.bold,
        )),
      ),
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
                  String docID = document.id;
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String noteText = data['note'];

                  return Card(
                    color: Colors.white70,
                    child: ListTile(
                      title: Text(noteText),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => openNoteBox(context,docIDs:docID),
                            icon: const Icon(Icons.settings),
                          ),
                          IconButton(
                            onPressed: () => firestoreService.deleteNote(docID),
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
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