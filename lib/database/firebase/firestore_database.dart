import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_keep_notes_clone/database/sqlite_database/models/notes.dart';

class FirestoreDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  insert(Notes notes) async {
    try {
      await _firestore
          .collection("notes")
          .doc("data")
          .collection(_firebaseAuth.currentUser!.uid)
          .doc(notes.id.toString())
          .set(notes.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  update(Notes notes) async {
    try {
      await _firestore
          .collection("notes")
          .doc("data")
          .collection(_firebaseAuth.currentUser!.uid)
          .doc(notes.id.toString())
          .update(notes.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  delete(int id) async {
    try {
      await _firestore
          .collection("notes")
          .doc("data")
          .collection(_firebaseAuth.currentUser!.uid)
          .doc(id.toString())
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
