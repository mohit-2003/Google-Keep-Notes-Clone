import 'package:flutter/material.dart';
import 'package:google_keep_notes_clone/screens/home_screen.dart';
import 'package:google_keep_notes_clone/utils/colors.dart';
import 'package:google_keep_notes_clone/widgets/navigation_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Keep Notes',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _navigationDrawerKey =
      new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _navigationDrawerKey,
      backgroundColor: bgColor,
      appBar: new PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: new SafeArea(
          child: new Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new InkWell(
                  onTap: () => _navigationDrawerKey.currentState?.openDrawer(),
                  child: new Icon(
                    Icons.menu,
                    color: primaryColor,
                  ),
                ),
                new Expanded(
                  child: new Container(
                    margin: EdgeInsets.only(left: 16),
                    child: new Text(
                      "Search your notes",
                      style: new TextStyle(
                          color: white.withOpacity(0.5), fontSize: 16),
                    ),
                  ),
                ),
                new Icon(
                  Icons.grid_view_outlined,
                  color: primaryColor,
                ),
                new Container(
                  margin: EdgeInsets.only(left: 8),
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(
                        "https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-1.2.1&raw_url=true&q=80&fm=jpg&crop=entropy&cs=tinysrgb&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      drawer: new NavigationDrawer(),
      body: new HomeScreen(),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: cardColor,
        onPressed: () {},
        child: new Icon(Icons.add),
      ),
    );
  }
}
