import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_keep_notes_clone/utils/colors.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bgColor,
        shadowColor: Colors.transparent,
        leading: new IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: new Icon(Icons.arrow_back)),
        actions: [
          new IconButton(
              onPressed: () {}, icon: new Icon(Icons.push_pin_outlined)),
          new IconButton(
              onPressed: () {}, icon: new Icon(Icons.add_alert_outlined)),
          new IconButton(
              onPressed: () {}, icon: new Icon(Icons.archive_outlined)),
        ],
      ),
      bottomNavigationBar: new BottomAppBar(
        color: bgColor,
        child: new Container(
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
      ),
      body: new Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: new Column(
          children: [
            new TextField(
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
}
