import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_keep_notes_clone/database/firebase/google_sign_in.dart';
import 'package:google_keep_notes_clone/screens/edit_screen.dart';
import 'package:google_keep_notes_clone/screens/loading_screen.dart';
import 'package:google_keep_notes_clone/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../database/sqlite_database/NotesDatabase.dart';
import '../widgets/navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _navigationDrawerKey =
      new GlobalKey<ScaffoldState>();
  bool isListViewItem = false;
  final db = NotesDatabase.instance;
  List<Map<String, dynamic>>? pinnedNotesList;
  List<Map<String, dynamic>>? otherNotesList;

  final currentUser = FirebaseAuth.instance.currentUser;
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
        ? new LoadingScreen()
        : new StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return new LoadingScreen();
              }
              return new Scaffold(
                key: _navigationDrawerKey,
                appBar: new PreferredSize(
                  preferredSize: Size.fromHeight(70),
                  child: new SafeArea(
                    child: new Container(
                      padding: EdgeInsets.all(8),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(80),
                          boxShadow: [
                            new BoxShadow(
                                color: black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 3)
                          ]),
                      child: new Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          new IconButton(
                            onPressed: () =>
                                _navigationDrawerKey.currentState?.openDrawer(),
                            icon: new Icon(
                              Icons.menu,
                              color: primaryColor,
                            ),
                          ),
                          new Expanded(
                            child: new Text(
                              "Search your notes",
                              textAlign: TextAlign.start,
                              style: new TextStyle(
                                  color: white.withOpacity(0.5), fontSize: 16),
                            ),
                          ),
                          new IconButton(
                            onPressed: () {
                              setState(() {
                                isListViewItem = !isListViewItem;
                              });
                            },
                            icon: new Icon(
                              isListViewItem
                                  ? Icons.grid_view_outlined
                                  : Icons.view_agenda_outlined,
                              color: primaryColor,
                            ),
                          ),
                          new Container(
                            margin: EdgeInsets.only(left: 8),
                            child: new InkWell(
                              onTap: () async {
                                final provider =
                                    Provider.of<GoogleSignInProvider>(context,
                                        listen: false);
                                await provider.logInWithGoogle();
                              },
                              child: new CircleAvatar(
                                backgroundImage: new NetworkImage(currentUser !=
                                        null
                                    ? currentUser!.photoURL!
                                    : "https://www.seekpng.com/png/full/41-410093_circled-user-icon-user-profile-icon-png.png"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                drawer: new NavigationDrawer(),
                body: otherNotesList!.isEmpty && pinnedNotesList!.isEmpty
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
                                    crossAxisCount: isListViewItem ? 2 : 4,
                                    staggeredTileBuilder: (index) =>
                                        StaggeredTile.fit(2),
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
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: new Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              new Text(
                                                pinnedNotesList![index]
                                                    ["title"],
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
                                                pinnedNotesList![index]
                                                    ["notes"],
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
                                    }),
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
                              new Container(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: new StaggeredGridView.countBuilder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: otherNotesList!.length,
                                  shrinkWrap: true,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  staggeredTileBuilder: (index) =>
                                      StaggeredTile.fit(2),
                                  crossAxisCount: isListViewItem ? 2 : 4,
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
                                            borderRadius:
                                                BorderRadius.circular(8)),
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
                                ),
                              )
                            ]),
                      ),
                floatingActionButton: new FloatingActionButton(
                  backgroundColor: cardColor,
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new EditScreen(
                        notes: null,
                      ),
                    ));
                  },
                  child: new Icon(
                    Icons.add,
                    color: primaryColor,
                  ),
                ),
              );
            });
  }
}
