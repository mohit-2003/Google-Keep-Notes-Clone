import 'package:google_keep_notes_clone/database/sqlite_database/NotesDatabase.dart';
import 'package:google_keep_notes_clone/database/sqlite_database/firebase/firestore_database.dart';
import 'package:google_keep_notes_clone/database/sqlite_database/models/notes.dart';

class Repository {
  final NotesDatabase notesDatabase = NotesDatabase.instance;
  final FirestoreDatabase firestoreDatabase = new FirestoreDatabase();

  Future<void> insertNotes(Notes notes) async {
    // local database
    int id = await notesDatabase.insert(notes);
    // TODO: check internet connection
    // firestore database
    notes.id = id;
    await firestoreDatabase.insert(notes);
  }

  Future<void> updateNotes(Notes notes) async {
    // local database
    await notesDatabase.update(notes);
    // TODO: check internet connection
    // firestore database
    await firestoreDatabase.update(notes);
  }

  Future<void> deleteNotes(int id) async {
    // local database
    await notesDatabase.delete(id);
    // TODO: check internet connection
    // firestore database
    await firestoreDatabase.delete(id);
  }
}
