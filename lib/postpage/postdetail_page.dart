import 'package:flutter/material.dart';
import 'package:hra/postpage/widgets.dart';
import 'package:hra/ui/newsFeedPage/widgets/feedBloc.dart';
import 'package:hra/ui/newsFeedPage/widgets/widgetFeed.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hra/config/app-config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hra/ui/newsFeedPage/widgets/feedCard.dart';
import 'package:path/path.dart' as p;
import 'package:video_player/video_player.dart';
import 'package:hra/ui/videoItem.dart';
import 'package:share/share.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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
  bool isdeleting = false;
  String username = "";
  String message = "";
  bool liked = false;
  bool saved = false;
  String profile_picture = "";

  Future<String> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userId") ?? "";

    setState(() {
      userId = id;
      username = prefs.getString('username') ?? "";
      profile_picture = prefs.getString('profilePicture') ?? "";
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
                  avatarImg: data["avatarImg"],
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
            feedId: jsonData['data']['uuid'],
            type: 1,
            title: comment,
            description: " ",
            isSaved: false,
            category: " ",
            subcategory: " ",
            time: " ",
            name: "You",
            avatarImg: profile_picture,
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

  Widget feedNewsCardWithImageItem(BuildContext context, Feed feed,
      String user_id, bool likes, String username) {
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
              userAvatarSection(context, feed, username),
              space15(),

              space15(),
              Text(feed.title,
                  style: TextStyle(fontSize: 14, color: Colors.black)),
              space15(),
              // show Image Preview
              p.extension(feed.bannerImg) == ".mp4"
                  ? VideoItems(
                      videoPlayerController: VideoPlayerController.networkUrl(
                          Uri.parse(feed.bannerImg)),
                      looping: false,
                      autoplay: true)
                  : feed.bannerImg != ''
                      ? Image.network(
                          feed.bannerImg,
                          fit: BoxFit.cover,
                          height: 180,
                          width: double.infinity,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              // Image is fully loaded
                              return child;
                            } else {
                              // Image is still loading, show a loading indicator
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            // This callback is called if the image couldn't be loaded
                            // You can display an error message or a placeholder image here
                            return Center(
                              child: Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 48.0,
                              ),
                            );
                          },
                        )
                      : Container(),

              space15(),
              // shows location
              // setLocation(feed),
              Divider(thickness: 1),

              Divider(thickness: 1),
              SizedBox(height: 10),
              likeCommentShare(context, feed, user_id, likes),
              space15(),
            ],
          ),
        ),
      ),
    );
  }

  Widget likeCommentShare(
      BuildContext context, Feed listFeed, String user_id, bool isLiked) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(),
                child: IconButton(
                  onPressed: () async {
                    if (isLiked || liked) {
                      // print('You already liked this post.');
                      // call unlike api
                      print("calling unlike");
                      if (await unlikeButtonTapped(user_id, listFeed.feedId)) {
                        setState(() {
                          liked = false;
                          isLiked = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Post Unliked.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    } else {
                      print("calling like");
                      if (await LikeButtonTapped(
                          user_id, listFeed.feedId, isLiked, listFeed, liked)) {
                        setState(() {
                          liked = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Post Liked.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        setState(() {
                          liked = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Something went wrong.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  },
                  icon: Icon(
                    Icons.thumb_up,
                    color: isLiked || liked ? Color(0xFFFF4D4D) : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            // print('Comment Tapped');
            // viewDetailPage1(context, listFeed.feedId.toString(), listFeed);
            // Handle commenting on the post here
          },
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.comment,
                size: 18,
              ),
              SizedBox(width: 5),
              Text(listFeed.comments)
            ],
          ),
        ),
        GestureDetector(
          onTap: () async {
            if (listFeed.isSaved || saved) {
              if (await UnSaveButtonTapped(
                  user_id, listFeed.feedId, listFeed.isSaved, context)) {
                setState(() {
                  saved = false;
                  listFeed.isSaved = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Post unsaved'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            } else {
              if (await SaveButtonTapped(
                  user_id, listFeed.feedId, listFeed.isSaved, context)) {
                setState(() {
                  saved = true;
                  listFeed.isSaved = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Post saved'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            }
          },
          child: Icon(
            FontAwesomeIcons.solidBookmark,
            size: 18,
            color: listFeed.isSaved || saved ? Color(0xFFFF4D4D) : Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () async {
            print('Share Tapped');
            // Handle sharing the post here
            // Share.share('https://www.onfocussoft.com');
            final imagedata = await http.get(Uri.parse(listFeed.bannerImg));
            final directory = await getApplicationDocumentsDirectory();
            String imagepath =
                '${directory.path}/${(listFeed.bannerImg.split("/")[listFeed.bannerImg.split("/").length - 1])}';
            await File(imagepath).writeAsBytes(imagedata.bodyBytes);
            ;
            await Share.shareFiles([imagepath], text: listFeed.bannerImg);
          },
          child: Icon(FontAwesomeIcons.shareAlt, size: 18),
        ),
      ],
    );
  }

  Future<bool> LikeButtonTapped(String user_id, String post_id, bool isLiked,
      Feed listFeed, bool liked) async {
    final response = await http.get(
      Uri.parse(
          '${AppConfig.apiUrl}/socialmedia/api/like?user_id=$user_id&post_id=$post_id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      message = jsonData['message'];
      print(jsonData);

      if (jsonData['status']) {
        return true;
      }

      return false;
    }

    return false;
  }

  Future<bool> unlikeButtonTapped(
    String user_id,
    String post_id,
  ) async {
    final response = await http.get(
      Uri.parse(
          '${AppConfig.apiUrl}/socialmedia/api/unlike?user_id=$user_id&post_id=$post_id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      message = jsonData['message'];
      print(jsonData);

      if (jsonData['status']) {
        return true;
      }

      return false;
    }

    return false;
  }

  Future<bool> SaveButtonTapped(String user_id, String post_id, bool isSaved,
      BuildContext context) async {
    print("post id is: ");
    print(post_id);
    print("User id is: ");
    print(user_id);
    final response = await http.post(
      Uri.parse('${AppConfig.apiUrl}/socialmedia/api/saved_post'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "saved_post_input": {
          "user_id": user_id,
          "post_id": post_id,
          "created_by": user_id,
          "updated_by": user_id,
        }
      }),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      message = jsonData['message'];
      print(jsonData);

      if (jsonData['status']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> UnSaveButtonTapped(String user_id, String post_id, bool isSaved,
      BuildContext context) async {
    final response = await http.post(
      Uri.parse('${AppConfig.apiUrl}/socialmedia/api/delete_saved_post'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "saved_post_input": {
          "user_id": user_id,
          "post_id": post_id,
          "created_by": user_id,
          "updated_by": user_id,
        }
      }),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      message = jsonData['message'];
      print(jsonData);

      if (jsonData['status']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
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
            Navigator.pop(context);
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
                feedNewsCardWithImageItem(
                    context, widget.feed, userId, widget.feed.likes, username),
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
                                othersComment(context, feedItem, username),
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
