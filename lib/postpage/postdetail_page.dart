import 'package:flutter/material.dart';
import 'package:hra/postpage/widgets.dart';
import 'package:hra/ui/newsFeedPage/widgets/feedBloc.dart';
import 'package:hra/ui/newsFeedPage/widgets/widgetFeed.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hra/config/app-config.dart';

class PostPageDetails extends StatefulWidget {
  final String postId;
  final Feed feed;
  PostPageDetails({Key? key, required this.postId, required this.feed})
      : super(key: key);

  @override
  _PostPageDetailsState createState() => _PostPageDetailsState();
}

class _PostPageDetailsState extends State<PostPageDetails> {
  List<Feed> feedList = [];
  String comment = "";
  bool isloading = false;
  bool isuploading = false;

  Future<void> fetchComments() async {
    setState(() {
      isloading = true;
    });
    final response = await http.post(
      Uri.parse(
          '${AppConfig.apiUrl}/socialmedia/api/comments/${widget.postId}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({}),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['data'] is List) {
        final List<dynamic> dataList = jsonData['data'];
        feedList = dataList
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
        print(feedList);
      }
    }
    setState(() {
      isloading = false;
    });
  }

  Future<void> postComment() async {
    setState(() {
      isuploading = true;
    });
    final response = await http.post(
      Uri.parse('${AppConfig.apiUrl}/user/api/comments/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({}),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);

      // add to feedList
    }
    setState(() {
      isuploading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    //fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildMessageComposer() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) {
                  setState(() {
                    comment = value;
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Add a cheerful comment',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              iconSize: 25.0,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                postComment();
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Post'),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                feedNewsCardWithImageItem(context, widget.feed),
                topSpace(),

                _buildMessageComposer(),

                //Comments
                isloading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : // Replace your ListView.builder with this code
                    Container(
                        height: MediaQuery.of(context).size.height -
                            200, // Adjust the height as needed
                        child: ListView.builder(
                          physics:
                              NeverScrollableScrollPhysics(), // Prevent scrolling
                          itemCount: feedList.length,
                          itemBuilder: (context, index) {
                            final feedItem = feedList[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                feedNewsCardWithImageItem(context, feedItem),
                                topSpace(),
                                const SizedBox(height: 30),
                                othersComment(context, feedItem),
                              ],
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
