import 'package:flutter/material.dart';
import 'package:hra/postpage/postdetail_page.dart';
import 'package:hra/ui/newsFeedPage/widgets/feedBloc.dart';
import 'package:hra/ui/newsFeedPage/widgets/widgetFeed.dart';
import 'package:hra/ui/newsFeedPage/FeedLatestArticle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  Future<void> fetchPosts() async {
    final response = await http.post(Uri.parse('/user/api/login-user'),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode({}));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);
    }
  }

  @override
  void initState() {
    super.initState();

    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: actionBarRow(),
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  topSpace(),
                  searchTextField(),
                  banner(),
                  // topSpace(),
                  //Container(height: 55, child: CategoryList()),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // List section for the News Feed.
                      GestureDetector(
                        onTap: viewDetailPage,
                        child: feedNewsCardWithImageItem(
                            context, FeedBloc().feedList[0]),
                      ),

                      topSpace(),
                      GestureDetector(
                        onTap: viewDetailPage,
                        child: feedNewsCardWithImageItem(
                            context, FeedBloc().feedList[0]),
                      ),

                      topSpace(),
                      GestureDetector(
                        onTap: viewDetailPage,
                        child: feedNewsCardWithImageItem(
                            context, FeedBloc().feedList[0]),
                      ),

                      topSpace(),
                      GestureDetector(
                        onTap: viewDetailPage,
                        child: feedNewsCardWithImageItem(
                            context, FeedBloc().feedList[0]),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget viewDetailPage() {
    print('Go To Detail Screen');
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => PostPageDetails()));
    return SizedBox();
  }
}
