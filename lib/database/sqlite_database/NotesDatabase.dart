import 'package:google_keep_notes_clone/database/sqlite_database/models/notes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  final _databaseName = "Notes.db";
  final _databaseVersion = 1;

  // making singleton class
  NotesDatabase._privateConstructor();
  static final NotesDatabase instance = NotesDatabase._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(path,
        version: _databaseVersion,
        onCreate: (database, version) => _createDatabase(database, version));
  }

  _createDatabase(Database database, int version) async {
    await database.execute('''CREATE TABLE Notes(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    title TEXT, notes TEXT,
    addedTime TEXT, editedTime TEXT, isPinned INTEGER
    )''');
  }

  // helper functions
  Future<int> insert(Notes notes) async {
    Database db = await instance.database;
    return await db.insert("Notes", notes.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> update(Notes notes) async {
    Database db = await instance.database;
    return await db.update(
      "Notes",
      notes.toMap(),
      where: "id = ?",
      whereArgs: [notes.id],
    );
  }

  Future<void> upsert(Notes notes) async {
    Database db = await instance.database;
    int res = await db.update(
      "Notes",
      notes.toMap(),
      where: "id = ?",
      whereArgs: [notes.id],
    );
    if (res == -1) {
      await db.insert("Notes", notes.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print("inserted");
    } else
      print("updated");
  }

  Future<int> delete(int notesId) async {
    Database db = await instance.database;
    return await db.delete(
      "Notes",
      where: "id = ?",
      whereArgs: [notesId],
    );
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    Database db = await instance.database;
    return await db.query("Notes", orderBy: "editedTime DESC");
  }

  Future<List<Map<String, dynamic>>> getAllPinnedNotes() async {
    Database db = await instance.database;
    return await db.query("Notes",
        orderBy: "editedTime DESC", where: "isPinned = ?", whereArgs: [1]);
  }

  Future<List<Map<String, dynamic>>> getAllUnPinnedNotes() async {
    Database db = await instance.database;
    return await db.query("Notes",
        orderBy: "editedTime DESC", where: "isPinned = ?", whereArgs: [0]);
  }

  Future<Map<String, dynamic>> getNotes(int notesID) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> list =
        await db.query("Notes", where: "id = ?", whereArgs: [notesID]);
    return list[0];
  }
}
