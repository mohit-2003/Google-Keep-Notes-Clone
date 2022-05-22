import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/notes.dart';

class FirestoreDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  insert(Notes notes) async {
    try {
      await _firestore
          .collection("notes")
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
          .doc(notes.id.toString())
          .update(notes.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  delete(int id) async {
    try {
      await _firestore.collection("notes").doc(id.toString()).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
