import 'package:flutter/material.dart';
import 'package:google_keep_notes_clone/screens/edit_screen.dart';
import 'package:google_keep_notes_clone/utils/colors.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../database/sqlite_database/NotesDatabase.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = NotesDatabase.instance;
  List<Map<String, dynamic>>? pinnedNotesList;
  List<Map<String, dynamic>>? otherNotesList;
  @override
  void initState() {
    super.initState();
    getNotesList();
  }

  getNotesList() async {
    otherNotesList = await db.getAllUnPinnedNotes();
    pinnedNotesList = await db.getAllPinnedNotes();
    setState(() {});
    print(pinnedNotesList);
    print(otherNotesList);
  }

  @override
  Widget build(BuildContext context) {
    return otherNotesList == null || pinnedNotesList == null
        ? new Center(
            child: new CircularProgressIndicator(
              color: primaryColor,
            ),
          )
        : otherNotesList!.isEmpty && pinnedNotesList!.isEmpty
            ? new Center(child: new Text("Empty"))
            : new SingleChildScrollView(
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Visibility(
                        visible: pinnedNotesList!.isNotEmpty,
                        child: new Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: new Text(
                            "Pinned",
                            style: new TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: new StaggeredGridView.countBuilder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: pinnedNotesList!.length,
                            shrinkWrap: true,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            crossAxisCount: 4,
                            itemBuilder: (context, index) {
                              return new InkWell(
                                onTap: () => Navigator.of(context)
                                    .push(new MaterialPageRoute(
                                  builder: (context) => new EditScreen(
                                      notes: pinnedNotesList![index]),
                                )),
                                child: new Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: new BoxDecoration(
                                      border: Border.all(
                                        color: white.withOpacity(0.4),
                                      ),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      new Text(
                                        pinnedNotesList![index]["title"],
                                        maxLines: 8,
                                        overflow: TextOverflow.ellipsis,
                                        style: new TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      new SizedBox(
                                        height: 8,
                                      ),
                                      new Text(
                                        pinnedNotesList![index]["notes"],
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                        style: new TextStyle(
                                            color: primaryColor, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            staggeredTileBuilder: (index) =>
                                StaggeredTile.fit(2)),
                      ),
                      new Visibility(
                        visible: otherNotesList!.isNotEmpty,
                        child: new Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: new Text(
                            "Others",
                            style: new TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      new RefreshIndicator(
                        onRefresh: () async {
                          await getNotesList();
                          setState(() {});
                        },
                        color: primaryColor,
                        child: new Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: new StaggeredGridView.countBuilder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: otherNotesList!.length,
                              shrinkWrap: true,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              crossAxisCount: 4,
                              itemBuilder: (context, index) {
                                return new InkWell(
                                  onTap: () => Navigator.of(context)
                                      .push(new MaterialPageRoute(
                                    builder: (context) => new EditScreen(
                                        notes: otherNotesList![index]),
                                  )),
                                  child: new Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: new BoxDecoration(
                                        border: Border.all(
                                          color: white.withOpacity(0.4),
                                        ),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        new Text(
                                          otherNotesList![index]["title"],
                                          maxLines: 8,
                                          overflow: TextOverflow.ellipsis,
                                          style: new TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        new SizedBox(
                                          height: 8,
                                        ),
                                        new Text(
                                          otherNotesList![index]["notes"],
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                          style: new TextStyle(
                                              color: primaryColor,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              staggeredTileBuilder: (index) =>
                                  StaggeredTile.fit(2)),
                        ),
                      )
                    ]),
              );
  }
}
