import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hra/ui/newsFeedPage/widgets/feedBloc.dart';
import 'package:hra/postpage/postdetail_page.dart';
import 'package:share/share.dart';
import 'package:like_button/like_button.dart';

Widget feedCard(BuildContext context, Feed listFeed) {
  Feed? feed;
  return Card(
    child: GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostPageDetails(
                    postId: '1',
                    feed: feed!,
                  ))),
      child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              renderCategoryTime(listFeed),
              space10(),
              userAvatarSection(context, listFeed),
              space15(),
              Text(listFeed.name,
                  softWrap: true,
                  maxLines: 2,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              space15(),
              Text(listFeed.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              space15(),
              setLocation(listFeed),
              Divider(thickness: 1),
              Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.addressBook),
                  SizedBox(width: 10),
                  Text(
                    '${listFeed.members} Members have this questions',
                    style: TextStyle(
                        fontSize: 14, color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              Divider(thickness: 1),
              SizedBox(height: 10),
              likeCommentShare(listFeed),
              space15(),
            ],
          )),
    ),
  );
}

Future<bool> onLikeButtonTapped(bool isLiked) async {
  return !isLiked;
}

Widget likeCommentShare(Feed listFeed) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      GestureDetector(
        onTap: () {
          print('Like Tapped');
          // Handle liking the post here
          // FbReactionBox();
        },
        child: Row(
          children: <Widget>[
            LikeButton(
              onTap: onLikeButtonTapped,
              size: 20,
              circleColor:
                  CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Color(0xff33b5e5),
                dotSecondaryColor: Color(0xff0099cc),
              ),
              likeBuilder: (bool isLiked) {
                return Icon(
                  Icons.thumb_up_outlined,
                  color: isLiked ? Color(0xFFFF4D4D) : Colors.black,
                  size: 20,
                );
              },
              likeCount: 0,
              countBuilder: (int? count, bool isLiked, String text) {
                var color = isLiked ? Color(0xFFFF4D4D) : Colors.black;
                Widget result;
                if (count == 0) {
                  result = Text(
                    "like",
                    style: TextStyle(color: color),
                  );
                } else
                  result = Text(
                    text,
                    style: TextStyle(color: color),
                  );
                return result;
              },
            ),
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          print('Comment Tapped');
          // Handle commenting on the post here
        },
        child: Row(
          children: <Widget>[
            Icon(FontAwesomeIcons.comment, size: 18),
            SizedBox(width: 5),
            Text(listFeed.comments)
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          print('Bookmark Tapped');
          // Handle bookmarking the post here
        },
        child: Icon(FontAwesomeIcons.bookmark, size: 18),
      ),
      GestureDetector(
        onTap: () {
          print('Share Tapped');
          // Handle sharing the post here
        },
        child: Icon(FontAwesomeIcons.shareAlt, size: 18),
      ),
    ],
  );
}

Widget setLocation(Feed listFeed) {
  return Row(
    children: <Widget>[
      Icon(Icons.location_on, color: Colors.teal),
      SizedBox(width: 15),
      Text(
        listFeed.location,
        style: TextStyle(fontSize: 12, color: Colors.teal),
      ),
    ],
  );
}

Widget userAvatarSection(BuildContext context, Feed listFeed) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: ClipOval(child: listFeed.avatarImg != '' ? Image.network(listFeed.avatarImg) : Image.asset('images/icon.png')),
                    radius: 20),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(listFeed.title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(listFeed.subcategory,
                            softWrap: true,
                            style: TextStyle(fontSize: 14, color: Colors.grey))
                      ],
                    ),
                    SizedBox(height: 4),
                    /*
                    Text('DIAGNOSED RECENTALLY',
                        style: TextStyle(fontSize: 12, color: Colors.teal)),*/
                  ],
                )
              ],
            ),
            moreOptions3Dots(context),
          ],
        ),
      )
    ],
  );
}

Widget moreOptions3Dots(BuildContext context) {
  return GestureDetector(
    // Just For Demo, Doesn't Work As Needed
    onTap: () =>
        _onCenterBottomMenuOn3DotsPressed(context), //_showPopupMenu(context),
    child: Container(
      child: Icon(FontAwesomeIcons.ellipsisV, size: 18),
    ),
  );
}

Widget space10() {
  return SizedBox(height: 10);
}

Widget space15() {
  return SizedBox(height: 10);
}

Widget renderCategoryTime(Feed listFeed) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(listFeed.category,
          style: TextStyle(fontSize: 14, color: Colors.grey[700])),
      Text(listFeed.time,
          style: TextStyle(fontSize: 14, color: Colors.grey[700])),
    ],
  );
}

_onCenterBottomMenuOn3DotsPressed(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xFF737373),
          child: _buildBottomNavMenu(context),
        );
      });
}

Widget _buildBottomNavMenu(BuildContext context) {
  List<Menu3DotsModel> listMore = [];
  listMore.add(Menu3DotsModel(
      'I don\'t want to see this', '', Icons.visibility_off_outlined));

  listMore.add(Menu3DotsModel('Report Post', '', Icons.flag_outlined));

  /*
  listMore.add(Menu3DotsModel(
      'Unfollow <username>', 'See fewer posts like this', Icons.person_add));

  listMore.add(Menu3DotsModel(
      'Copy <Post type> link', 'See fewer posts like this', Icons.insert_link));*/

  return Container(
    height: 120,
    decoration: BoxDecoration(
      color: Theme.of(context).canvasColor,
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(10),
        topRight: const Radius.circular(10),
      ),
    ),
    child: ListView.builder(
        itemCount: listMore.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              listMore[index].title,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            subtitle: Text(listMore[index].subtitle),
            leading: Icon(
              listMore[index].icons,
              size: 20,
              color: Colors.grey,
            ),
          );
        }),
  );
}

class Menu3DotsModel {
  String title;
  String subtitle;
  IconData icons;

  Menu3DotsModel(this.title, this.subtitle, this.icons);
}
