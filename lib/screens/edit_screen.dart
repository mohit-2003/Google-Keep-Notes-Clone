import 'package:flutter/material.dart';
import 'package:google_keep_notes_clone/database/repository.dart';
import 'package:google_keep_notes_clone/database/sqlite_database/NotesDatabase.dart';
import 'package:google_keep_notes_clone/database/sqlite_database/models/notes.dart';
import 'package:google_keep_notes_clone/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class EditScreen extends StatefulWidget {
  final notes;
  const EditScreen({Key? key, required this.notes}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  bool isPinned = false;
  var editedTime =
      DateFormat.jm().format(DateTime.parse(DateTime.now().toString()));
  final _titleController = new TextEditingController();
  final _notesController = new TextEditingController();
  // final NotesDatabase db = NotesDatabase.instance;
  final Repository repository = new Repository();
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
    return new WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        saveNotes();
        return true;
      },
      child: new Scaffold(
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
                  "Edited $editedTime",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              new IconButton(
                  onPressed: () {
                    showBottomSheet();
                  },
                  icon: new Icon(Icons.more_vert)),
            ],
          ),
        ),
        body: new Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: new Column(
            children: [
              new TextField(
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.normal),
                maxLines: null,
                controller: _titleController,
                cursorColor: Colors.grey,
                keyboardType: TextInputType.multiline,
                decoration: new InputDecoration(
                    hintText: "Title",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.grey),
                    border: InputBorder.none),
              ),
              new Expanded(
                child: new TextField(
                  maxLines: 99999,
                  controller: _notesController,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.multiline,
                  decoration: new InputDecoration(
                      hintText: "Note",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.grey),
                      border: InputBorder.none),
                ),
              )
            ],
          ),
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
        await repository.insertNotes(notes);
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
        await repository.updateNotes(notes);
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
        editedTime =
            DateFormat.jm().format(DateTime.parse(widget.notes["editedTime"]));
      });
    }
  }

  showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return new Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              new ListTile(
                onTap: () {
                  deleteNotes();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                leading: new Icon(Icons.delete_outline),
                title: new Text("Delete"),
              ),
              new ListTile(
                onTap: () {},
                leading: new Icon(Icons.filter_none),
                title: new Text("Make a copy"),
              ),
              new ListTile(
                onTap: () {},
                leading: new Icon(Icons.share_outlined),
                title: new Text("Send"),
              ),
              new ListTile(
                onTap: () {},
                leading: new Icon(Icons.person_add),
                title: new Text("Collaborator"),
              ),
              new ListTile(
                onTap: () {},
                leading: new Icon(Icons.label_outline),
                title: new Text("Lebels"),
              )
            ],
          );
        });
  }

  void deleteNotes() async {
    if (widget.notes != null) {
      repository.deleteNotes(widget.notes["id"]);
    }
  }
}
