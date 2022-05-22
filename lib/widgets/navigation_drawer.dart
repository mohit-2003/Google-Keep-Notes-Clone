import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_keep_notes_clone/screens/settings_screen.dart';
import 'package:google_keep_notes_clone/utils/colors.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      backgroundColor: bgColor,
      child: new SafeArea(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Container(
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              child: new RichText(
                  text: new TextSpan(children: [
                new TextSpan(
                    text: "Google",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22)),
                new TextSpan(text: " Keep", style: new TextStyle(fontSize: 22))
              ])),
            ),
            RowItems(
              new Icon(
                Icons.lightbulb_outlined,
                color: primaryColor,
              ),
              "Notes",
              () {},
            ),
            RowItems(
              new Icon(
                Icons.notifications_outlined,
                color: primaryColor,
              ),
              "Reminders",
              () {},
            ),
            RowItems(
              new Icon(
                Icons.add,
                color: primaryColor,
              ),
              "Create new lebel",
              () {},
            ),
            RowItems(
              new Icon(
                Icons.archive_outlined,
                color: primaryColor,
              ),
              "Archive",
              () {},
            ),
            RowItems(
              new Icon(
                Icons.delete_outline,
                color: primaryColor,
              ),
              "Trash",
              () {},
            ),
            RowItems(
              new Icon(
                Icons.settings_outlined,
                color: primaryColor,
              ),
              "Settings",
              () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new SettingScreen()));
              },
            ),
            RowItems(
              new Icon(
                Icons.help_outline,
                color: primaryColor,
              ),
              "Help & feedback",
              () {},
            )
          ],
        ),
      ),
    );
  }

  Widget RowItems(Icon icon, String title, VoidCallback onClicked) {
    return new Container(
      margin: EdgeInsets.only(left: 20, right: 10),
      child: TextButton(
          // style: ButtonStyle(
          //     backgroundColor:
          //         MaterialStateProperty.all(Colors.grey.withOpacity(0.7)),
          //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //         RoundedRectangleBorder(
          //       borderRadius: BorderRadius.only(
          //           topRight: Radius.circular(50),
          //           bottomRight: Radius.circular(50)),
          //     ))),
          onPressed: () {
            onClicked();
          },
          child: new Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                icon,
                new Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(
                    title,
                    style: TextStyle(color: primaryColor, fontSize: 16),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
