import 'package:flutter/material.dart';
import 'package:google_keep_notes_clone/database/sqlite_database/NotesDatabase.dart';
import 'package:google_keep_notes_clone/database/sqlite_database/models/notes.dart';
import 'package:google_keep_notes_clone/utils/colors.dart';

class EditScreen extends StatefulWidget {
  final notes;
  const EditScreen({Key? key, required this.notes}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  bool isPinned = false;
  final _titleController = new TextEditingController();
  final _notesController = new TextEditingController();
  // Notes? notes;
  final NotesDatabase db = NotesDatabase.instance;
  @override
  void initState() {
    super.initState();
    getNotes();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bgColor,
        shadowColor: Colors.transparent,
        leading: new IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            saveNotes();
          },
          icon: new Icon(Icons.arrow_back),
        ),
        actions: [
          new IconButton(
              onPressed: () {
                setState(() {
                  isPinned = !isPinned;
                });
              },
              icon: new Icon(
                  isPinned ? Icons.push_pin : Icons.push_pin_outlined)),
          new IconButton(
              onPressed: () {}, icon: new Icon(Icons.add_alert_outlined)),
          new IconButton(
              onPressed: () {}, icon: new Icon(Icons.archive_outlined)),
        ],
      ),
      bottomNavigationBar: new BottomAppBar(
        color: bgColor,
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new IconButton(
                onPressed: () {}, icon: new Icon(Icons.add_box_outlined)),
            new IconButton(
                onPressed: () {}, icon: new Icon(Icons.color_lens_outlined)),
            new Expanded(
              child: new Text(
                "Edited 6:48 AM",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            new IconButton(onPressed: () {}, icon: new Icon(Icons.more_vert)),
          ],
        ),
      ),
      body: new Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: new Column(
          children: [
            new TextField(
              controller: _titleController,
              cursorColor: Colors.grey,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                  hintText: "Title",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.grey),
                  border: InputBorder.none),
            ),
            new TextField(
              controller: _notesController,
              cursorColor: Colors.grey,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                  hintText: "Note",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.grey),
                  border: InputBorder.none),
            )
          ],
        ),
      ),
    );
  }

  void saveNotes() async {
    String title = _titleController.text;
    String note = _notesController.text;
    if (title.isNotEmpty || note.isNotEmpty) {
      if (widget.notes == null) {
        //insert
        Notes notes = new Notes(
            title: title,
            notes: note,
            addedTime: new DateTime.now().toIso8601String(),
            editedTime: new DateTime.now().toIso8601String(),
            isPinned: isPinned);
        await db.insertNotes(notes);
        print("inserted");
      } else {
        //update
        Notes notes = new Notes(
            id: widget.notes["id"],
            title: title,
            notes: note,
            addedTime: widget.notes["addedTime"],
            editedTime: new DateTime.now().toIso8601String(),
            isPinned: isPinned);
        await db.updateNotes(notes);
        print("updated");
      }
    }
  }

  void getNotes() {
    if (widget.notes != null) {
      setState(() {
        _titleController.text = widget.notes["title"];
        _notesController.text = widget.notes["notes"];
        isPinned = widget.notes["isPinned"] == 1;
      });
    }
  }
}
