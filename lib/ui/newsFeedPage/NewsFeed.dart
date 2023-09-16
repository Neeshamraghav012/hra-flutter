import 'package:flutter/material.dart';
import 'package:hra/postpage/postdetail_page.dart';
import 'package:hra/ui/newsFeedPage/widgets/feedBloc.dart';
import 'package:hra/ui/newsFeedPage/widgets/widgetFeed.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hra/config/app-config.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  List<Feed> feedListData = [];
  bool isloading = false;
  String userId = "";

  Future<String> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userId") ?? "";

    setState(() {
      userId = id;
    });
    print(id);
    return id;
  }

  Future<void> fetchPosts() async {
    setState(() {
      isloading = true;
    });
    final response = await http.get(
      Uri.parse('${AppConfig.apiUrl}/socialmedia/api/posts?user_id=$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['data'] is List) {
        final List<dynamic> dataList = jsonData['data'];
        feedListData = dataList
            .asMap()
            .map((index, data) {
              return MapEntry(
                index,
                Feed(
                  id: index,
                  feedId: data['id'],
                  type: 1,
                  title: data['title'],
                  description: ' ',
                  category: ' ',
                  subcategory: ' ',
                  time: ' ',
                  name: data['username'],
                  avatarImg: data['avatarImg'],
                  bannerImg: data['bannerImg'],
                  location: ' ',
                  likes: 0,
                  comments: '0',
                  members: '0',
                ),
              );
            })
            .values
            .toList();
        print("feedlist is: ");
        print(feedListData);
      }
    }

    setState(() {
      isloading = false;
    });
  }

  Future<void> initializeData() async {
    await getUser();
    fetchPosts();
  }

  @override
  void initState() {
    super.initState();
    initializeData();
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
                  searchTextField(context),
                  banner(),
                  // topSpace(),
                  //Container(height: 55, child: CategoryList()),
                ],
              ),
            ),
            isloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        itemCount: feedListData.length,
                        itemBuilder: (context, index) {
                          final feedItem = feedListData[index];
                          return GestureDetector(
                            onTap: () => viewDetailPage(
                                feedItem.feedId.toString(), feedItem),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                feedNewsCardWithImageItem(context, feedItem, userId),
                                topSpace(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget viewDetailPage(String postId, Feed feed) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PostPageDetails(
                  postId: postId,
                  feed: feed,
                )));
    return SizedBox();
  }
}
