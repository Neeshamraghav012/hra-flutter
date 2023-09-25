import 'package:flutter/material.dart';
import 'package:hra/postpage/widgets.dart';
import 'package:hra/ui/newsFeedPage/widgets/feedBloc.dart';
import 'package:hra/ui/newsFeedPage/widgets/widgetFeed.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hra/config/app-config.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String userId = "";

  Future<String> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userId") ?? "";

    setState(() {
      userId = id;
    });

    return id;
  }

  void initializeData() async {
    await getUser();
  }

  TextEditingController _textEditingController = TextEditingController();

  Future<void> fetchComments() async {
    setState(() {
      isloading = true;
    });
    final response = await http.get(
      Uri.parse(
          '${AppConfig.apiUrl}/socialmedia//api/fetch_comment?post_id=${widget.postId}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);
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
                  isSaved: false,
                  category: ' ',
                  subcategory: ' ',
                  time: ' ',
                  name: data['username'],
                  avatarImg: "",
                  bannerImg: "",
                  location: ' ',
                  likes: true,
                  comments: '0',
                  members: '0',
                ),
              );
            })
            .values
            .toList();
        print("comment list is: ");
        print(feedList);
      }
    }
    setState(() {
      isloading = false;
    });
  }

  Future<int> postComment(String feedId) async {
    setState(() {
      isuploading = true;
    });
    final response = await http.post(
      Uri.parse('${AppConfig.apiUrl}/socialmedia/api/comment'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "comment_input": {
          "user_id": userId,
          "post_id": feedId,
          "comment": comment,
          "updated_by": userId,
          "created_by": userId,
        }
      }),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      if (jsonData['status']) {
        Feed latestcomment = Feed(
            feedId: " ",
            type: 1,
            title: comment,
            description: " ",
            isSaved: false,
            category: " ",
            subcategory: " ",
            time: " ",
            name: "You",
            avatarImg: "",
            bannerImg: "",
            location: " ",
            likes: false,
            comments: widget.feed.comments.toString(),
            members: " ");

        // Insert the new feed at the beginning of the list

        setState(() {
          comment = '';
          _textEditingController.text = "";
          feedList.insert(0, latestcomment);
          isuploading = false;
          widget.feed.comments =
              (int.parse(widget.feed.comments) + 1).toString();
        });
      }

      return 1;
    }
    setState(() {
      isuploading = false;
    });
    return 0;
  }

  @override
  void initState() {
    super.initState();
    initializeData();
    fetchComments();
    print("feed is : ");
    print(widget.feed);
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildMessageComposer(String feedId) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                controller: _textEditingController,
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
            isuploading
                ? CircularProgressIndicator()
                : IconButton(
                    icon: Icon(Icons.send),
                    iconSize: 25.0,
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      int status = await postComment(feedId);
                      if (status == 1) {
                        var snackdemo = SnackBar(
                          content: Text("Your comment has been posted!"),
                          backgroundColor: Colors.green,
                          elevation: 10,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(5),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                      } else {
                        var snackdemo = SnackBar(
                          content:
                              Text("Something went wrong, please try again"),
                          backgroundColor: Colors.green,
                          elevation: 10,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(5),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                      }
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
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context);
          },
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                feedNewsCardWithImageItem(context, widget.feed, userId, widget.feed.likes),
                topSpace(),

                _buildMessageComposer(widget.feed.feedId),

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
