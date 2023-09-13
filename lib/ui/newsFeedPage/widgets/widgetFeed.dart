import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hra/ui/newsFeedPage/widgets/feedBloc.dart';
import 'package:hra/ui/newsFeedPage/widgets/feedCard.dart';
import 'package:hra/ui/createPost.dart';

Widget actionBarRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.menu,
                color: Color(0xFFFF4D4D),
              )
            ],
          )
        ],
      ),
      CircleAvatar(
          child: ClipOval(
              child: Image(
            image: AssetImage('images/icon.png'),
          )),
          radius: 20,
          backgroundColor: Colors.grey)
    ],
  );
}

Widget searchTextField(context) {
  return Container(
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            child: Container(
              height: 100,
              padding: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => createPage()),
                  );
                  return;
                },
                maxLines: null, // Allows multiple lines of text
                decoration: InputDecoration.collapsed(
                  hintText: "What's on your mind?",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget banner() {
  return Container(
    width: double.infinity,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: Colors.grey, width: 0.5),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Image.asset(
        'images/ad.jpg', // Replace with the path to your image asset
        fit: BoxFit.contain, // Adjust the fit as needed
      ),
    ),
  );
}

BoxDecoration boxDecoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      border:
          Border.all(width: 1, style: BorderStyle.solid, color: Colors.teal));
}

BoxDecoration selectedBoxDecoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color: Colors.teal[200],
      border:
          Border.all(width: 1, style: BorderStyle.solid, color: Colors.teal));
}

Widget topSpace() {
  return SizedBox(height: 10);
}

Widget feedNewsCardItem(BuildContext context, Feed feed) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(
            style: BorderStyle.solid, color: Colors.grey, width: 0.5)),
    child: Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            renderCategoryTime(feed),
            space10(),
            userAvatarSection(context, feed),
            space15(),
            Visibility(
                visible: feed.name.isEmpty == true ? false : true,
                child: Text(feed.name,
                    softWrap: true,
                    maxLines: 2,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            space15(),
            Visibility(
                visible: feed.description.isEmpty == true ? false : true,
                child: Text(feed.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey))),
            space15(),
            setLocation(feed),
            Divider(thickness: 1),
            Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.addressBook),
                SizedBox(width: 10),
                Text(
                  '${feed.members} Members have this questions',
                  style: TextStyle(
                      fontSize: 14, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            Divider(thickness: 1),
            SizedBox(height: 10),
            likeCommentShare(feed),
            space15(),
          ],
        ),
      ),
    ),
  );
}

Widget feedNewsCardItemQuestion(BuildContext context, Feed feed) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(
            style: BorderStyle.solid, color: Colors.grey, width: 0.5)),
    child: Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            renderCategoryTime(feed),
            space10(),
            userAvatarSection(context, feed),
            space15(),
            Visibility(
                visible: feed.name.isEmpty == true ? false : true,
                child: Text(feed.name,
                    softWrap: true,
                    maxLines: 2,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            space15(),
            setLocation(feed),
            space15(),
            questionPallet(),
            space15(),
            Divider(thickness: 1),
            Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.addressBook),
                SizedBox(width: 10),
                Text(
                  '${feed.members} Members have this questions',
                  style: TextStyle(
                      fontSize: 14, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            Divider(thickness: 1),
            SizedBox(height: 10),
            likeCommentShare(feed),
            space15(),
          ],
        ),
      ),
    ),
  );
}

Widget feedNewsCardWithImageItem(BuildContext context, Feed feed) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(
            style: BorderStyle.solid, color: Colors.grey, width: 0.5)),
    child: Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // renderCategoryTime(feed),
            space10(),
            userAvatarSection(context, feed),
            space15(),
            /*
            Text(feed.name,
                softWrap: true,
                maxLines: 2,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),*/
            space15(),
            Text(feed.title,
                style: TextStyle(fontSize: 14, color: Colors.black)),
            space15(),
            // show Image Preview

            feed.bannerImg != ''
                ? Image.network(feed.bannerImg,
                    fit: BoxFit.cover, height: 180, width: double.infinity)
                : Image.asset("images/home.jpg",
                    fit: BoxFit.cover, height: 180, width: double.infinity),

            space15(),
            // shows location
            // setLocation(feed),
            Divider(thickness: 1),
            /*
            Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.addressBook),
                SizedBox(width: 10),
                Text(
                  '${feed.members} Members have this questions',
                  style: TextStyle(
                      fontSize: 14, color: Theme.of(context).primaryColor),
                ),
              ],
            ),*/
            Divider(thickness: 1),
            SizedBox(height: 10),
            likeCommentShare(feed),
            space15(),
          ],
        ),
      ),
    ),
  );
}

Widget btnDecoration(String btnText) {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color(0xFFFF4D4D),
      ),
      child: Text(
        btnText,
        style: TextStyle(fontSize: 12, color: Colors.grey[100]),
      ));
}

Widget questionPallet() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    height: 100,
    decoration: BoxDecoration(color: Colors.teal[100]),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Are you going?', style: TextStyle(fontSize: 18)),
            Row(
              children: <Widget>[
                Icon(Icons.people),
                SizedBox(
                  width: 4,
                ),
                Text('21 People going?', style: TextStyle(fontSize: 12))
              ],
            )
          ],
        ),
        Row(
          children: <Widget>[
            btnDecoration('No'),
            SizedBox(width: 20),
            btnDecoration('Yes')
          ],
        )
      ],
    ),
  );
}

Widget pollingCard(BuildContext context, Feed feed) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(
            style: BorderStyle.solid, color: Colors.grey, width: 0.5)),
    child: Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            renderCategoryTime(feed),
            space10(),
            userAvatarSection(context, feed),
            space15(),
            Visibility(
                visible: feed.name.isEmpty == true ? false : true,
                child: Text(feed.name,
                    softWrap: true,
                    maxLines: 2,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            space15(),
            pollCartSection(),
            space15(),
            setLocation(feed),
            Divider(thickness: 1),
            Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.addressBook),
                SizedBox(width: 10),
                Text(
                  'You and ${feed.members} Members Liked this poll',
                  style: TextStyle(
                      fontSize: 14, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            Divider(thickness: 1),
            SizedBox(height: 10),
            likeCommentShare(feed),
            space15(),
          ],
        ),
      ),
    ),
  );
}

Widget pollCartSection() {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          pollQuestion('Apollo Hospital, Banglore'),
          pollQuestion('20%'),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          pollQuestion('AIIMS Delhi'),
          pollQuestion('20%'),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          pollQuestion('Kokila Ben Dhirubhai Ambani, Mumbai'),
          pollQuestion('50%')
        ],
      )
    ],
  );
}

Widget pollQuestion(String question) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration:
        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
    child: Text(question),
  );
}
