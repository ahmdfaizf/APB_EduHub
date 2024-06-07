import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreNoteServices{

  final CollectionReference notes = FirebaseFirestore.instance.collection("Note");
  //Create Note
  Future<void> addNote(String note){
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now()
    });
  }
  //Read Note
  Stream<QuerySnapshot> getNoteStream(){
    final noteStream = notes.orderBy('timestamp', descending: true).snapshots();

    return noteStream;
  }
  //Update Note

  //Delete Note
}