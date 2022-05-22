import 'package:flutter/material.dart';
import 'package:google_keep_notes_clone/utils/colors.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var themeMode = ThemeMode.system;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: bgColor,
        leading: new IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: new Icon(Icons.arrow_back)),
        title: new Text("Settings"),
      ),
      body: new Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getHeader("Display Options"),
            new Row(
              children: [
                new Expanded(
                  child: new Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: new Text(
                      "Add new items to bottom",
                      style: new TextStyle(fontSize: 16, color: primaryColor),
                    ),
                  ),
                ),
                new Switch(
                  value: true,
                  onChanged: (isChecked) => null,
                  activeColor: Colors.blue,
                )
              ],
            ),
            new Row(
              children: [
                new Expanded(
                  child: new Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: new Text(
                      "Move checked items to bottom",
                      style: new TextStyle(fontSize: 16, color: primaryColor),
                    ),
                  ),
                ),
                new Switch(
                  value: true,
                  onChanged: (isChecked) => !isChecked,
                  activeColor: Colors.blue,
                )
              ],
            ),
            new Row(
              children: [
                new Expanded(
                  child: new Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: new Text(
                      "Display rick link previews",
                      style: new TextStyle(fontSize: 16, color: primaryColor),
                    ),
                  ),
                ),
                new Switch(
                  value: true,
                  onChanged: (isChecked) => !isChecked,
                  activeColor: Colors.blue,
                )
              ],
            ),
            new InkWell(
              onTap: () {
                showThemeDialog(context);
              },
              child: new Row(
                children: [
                  new Expanded(
                    child: new Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      child: new Text(
                        "Theme",
                        style: new TextStyle(fontSize: 16, color: primaryColor),
                      ),
                    ),
                  ),
                  new Text(
                    "System dafault",
                    style: new TextStyle(fontSize: 16, color: primaryColor),
                  ),
                ],
              ),
            ),
            getHeader("Reminder defaults"),
            new Row(
              children: [
                new Expanded(
                  child: new Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: new Text(
                      "Morning",
                      style: new TextStyle(fontSize: 16, color: primaryColor),
                    ),
                  ),
                ),
                new Text(
                  "8:00 AM",
                  style: new TextStyle(fontSize: 16, color: primaryColor),
                ),
              ],
            ),
            new Row(
              children: [
                new Expanded(
                  child: new Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: new Text(
                      "Afternoon",
                      style: new TextStyle(fontSize: 16, color: primaryColor),
                    ),
                  ),
                ),
                new Text(
                  "1:00 PM",
                  style: new TextStyle(fontSize: 16, color: primaryColor),
                ),
              ],
            ),
            new Row(
              children: [
                new Expanded(
                  child: new Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: new Text(
                      "Evening",
                      style: new TextStyle(fontSize: 16, color: primaryColor),
                    ),
                  ),
                ),
                new Text(
                  "6:00 PM",
                  style: new TextStyle(fontSize: 16, color: primaryColor),
                ),
              ],
            ),
            getHeader("Sharing"),
            new Row(
              children: [
                new Expanded(
                  child: new Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: new Text(
                      "Enable sharing",
                      style: new TextStyle(fontSize: 16, color: primaryColor),
                    ),
                  ),
                ),
                new Switch(
                  value: true,
                  onChanged: (isChecked) => !isChecked,
                  activeColor: Colors.blue,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  getHeader(String text) {
    return new Container(
      margin: EdgeInsets.only(top: 16),
      child: new Text(
        text,
        style: new TextStyle(color: Colors.lightBlue),
      ),
    );
  }

  void showThemeDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return new StatefulBuilder(builder: (context, setState) {
            return new Dialog(
                backgroundColor: cardColor,
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                child: new Container(
                  padding: EdgeInsets.all(16),
                  child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Text(
                          "Choose theme",
                          style: new TextStyle(fontSize: 24),
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Radio(
                                activeColor: Colors.lightBlue,
                                value: ThemeMode.light,
                                groupValue: themeMode,
                                onChanged: (ThemeMode? value) {
                                  setState(() {
                                    themeMode = value!;
                                  });
                                }),
                            new Text("Light"),
                          ],
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Radio(
                                activeColor: Colors.lightBlue,
                                value: ThemeMode.dark,
                                groupValue: themeMode,
                                onChanged: (ThemeMode? value) {
                                  setState(() {
                                    themeMode = value!;
                                  });
                                }),
                            new Text("Dark"),
                          ],
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Radio(
                                activeColor: Colors.lightBlue,
                                value: ThemeMode.system,
                                groupValue: themeMode,
                                onChanged: (ThemeMode? value) {
                                  setState(() {
                                    themeMode = value!;
                                  });
                                }),
                            new Text("System default"),
                          ],
                        ),
                        new Align(
                          alignment: Alignment.centerRight,
                          child: new TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: new Text(
                                "Cancel",
                                textAlign: TextAlign.end,
                                style: new TextStyle(color: Colors.lightBlue),
                              )),
                        )
                      ]),
                ));
          });
        });
  }
}
