import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hra/ui/newsFeedPage/widgets/feedBloc.dart';
import 'package:hra/ui/newsFeedPage/widgets/feedCard.dart';
import 'package:share/share.dart';
import 'package:carousel_slider/carousel_slider.dart';

Widget linearProgressIndicator() {
  return LinearProgressIndicator(
    backgroundColor: Colors.red,
  );
}

Widget othersComment(BuildContext context, Feed feed, String username) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
            backgroundColor: Colors.grey,
            child: ClipOval(child: Image.asset('images/icon.png')),
            radius: 20),
        SizedBox(width: 20),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                  style: BorderStyle.solid, color: Colors.grey, width: 0.5)),
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  usernameSectionWithoutAvatar(
                      context, feed.name == " " ? "User" : feed.name, feed, username),
                  space15(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(feed.title,
                        softWrap: true,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ),
                  space15(),
                  // Divider(thickness: 1),
                  SizedBox(height: 10),
                  // menuReply(feed),
                  space15(),
                ],
              ),
            ),
          ),
        )
            )
      ],
    ),
  );
}


Widget usernameSectionWithoutAvatar(BuildContext context, String username, Feed feed, String user) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(username,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            username == user || username == "You" ? moreOptions3Dots(context, feed) : Container(),
          ],
        ),
      )
    ],
  );
}

Widget commentReply(BuildContext context, Feed feed) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                  style: BorderStyle.solid, color: Colors.grey, width: 0.5)),
          child: Container(
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  //usernameSectionWithoutAvatar(context),
                  //space15(),
                  Text(
                      'Not sure about rights. Looks like its matter of concern that our shool dont take it seriously such matters and trats it like lightly that it is fault of student',
                      softWrap: true,
                      maxLines: 3,
                      style: TextStyle(fontSize: 14)),
                  space15(),

                  Divider(thickness: 1),
                  SizedBox(height: 10),
                  menuCommentReply(feed),
                  space15(),
                ],
              ),
            ),
          ),
        )
            //commentReply(context, FeedBloc().feedList[2]),
            ),
        SizedBox(width: 20),
        CircleAvatar(
            backgroundColor: Colors.grey,
            child: ClipOval(
                child: Image.network(
                    'https://www.w3schools.com/w3images/avatar4.png')),
            radius: 20),
      ],
    ),
  );
}

Widget menuCommentReply(Feed listFeed) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      GestureDetector(
          onTap: () => debugPrint('${listFeed.likes} tapped'),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.arrowUp,
                size: 16,
                color: Colors.teal,
              ),
              SizedBox(width: 5),
              Text(
                '${listFeed.likes}',
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              )
            ],
          )),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
                onTap: () => debugPrint('Comment Tapped'),
                child: Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.arrowDown, size: 16),
                    SizedBox(width: 5),
                    Text(
                      listFeed.comments,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )
                  ],
                ))
          ]),
      GestureDetector(
          onTap: () {
            Share.share('check out my website https://example.com');
          },
          child: Icon(Icons.share, size: 18)),
      GestureDetector(onTap: () {}, child: Icon(Icons.linear_scale, size: 18)),
    ],
  );
}
