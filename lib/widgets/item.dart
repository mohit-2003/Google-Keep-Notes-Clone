import 'package:flutter/material.dart';
import 'package:google_keep_notes_clone/screens/loading_screen.dart';
import 'package:google_keep_notes_clone/utils/colors.dart';

class NotesItem extends StatelessWidget {
  final notes;
  final VoidCallback onClicked;
  const NotesItem({Key? key, required this.notes, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return notes == null
        ? new Container()
        : new InkWell(
            onTap: onClicked,
            child: new Container(
              padding: EdgeInsets.all(16),
              decoration: new BoxDecoration(
                  border: Border.all(
                    color: white.withOpacity(0.4),
                  ),
                  borderRadius: BorderRadius.circular(8)),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Text(
                    notes["title"],
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
                    notes["notes"],
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(color: primaryColor, fontSize: 16),
                  ),
                ],
              ),
            ),
          );
  }
}
