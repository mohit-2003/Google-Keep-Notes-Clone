import 'package:flutter/material.dart';
import 'package:google_keep_notes_clone/utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String note =
      "THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE";
  String note1 = "THIS IS NOTE THIS IS NOTE THIS IS NOTE";
  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child:
          new Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        new Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: new Text(
            "Pinned",
            style:
                new TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        new Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: new StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1,
              shrinkWrap: true,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              crossAxisCount: 4,
              itemBuilder: (context, index) {
                return new Container(
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
                        "Heading",
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
                        note.toLowerCase(),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(color: primaryColor, fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
              staggeredTileBuilder: (index) => StaggeredTile.fit(2)),
        ),
        new Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: new Text(
            "Others",
            style:
                new TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        new Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: new StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              shrinkWrap: true,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              crossAxisCount: 4,
              itemBuilder: (context, index) {
                return new Container(
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
                        "Heading",
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
                        note.toLowerCase(),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(color: primaryColor, fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
              staggeredTileBuilder: (index) => StaggeredTile.fit(2)),
        )
      ]),
    );
  }
}
