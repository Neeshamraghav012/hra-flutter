import 'package:flutter/material.dart';
import 'package:hra/postpage/postdetail_page.dart';
import 'package:hra/ui/newsFeedPage/widgets/feedBloc.dart';
import 'package:hra/ui/newsFeedPage/widgets/widgetFeed.dart';
import 'package:hra/ui/profilePage/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hra/config/app-config.dart';
import 'package:hra/user-registration/login.dart';
import 'package:hra/ui/home.dart';
import 'package:hra/admin/articlelist.dart';
import 'package:hra/admin/gallery.dart';
import 'package:hra/admin/eventlist.dart';
import 'package:hra/admin/networkmembers.dart';
import 'package:hra/admin/training-material.dart';
import 'package:hra/admin/brochures.dart';
import 'package:hra/admin/certificate.dart';
import 'package:path/path.dart' as p;
import 'package:video_player/video_player.dart';
import 'package:hra/ui/videoItem.dart';
import 'package:hra/ui/newsFeedPage/widgets/feedCard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  List<Feed> feedListData = [];
  bool isloading = false;
  String userId = "";
  String username = "";
  String email = "";
  bool user_loading = false;
  String profile_picture = '';
  bool liked = false;
  bool saved = false;

  Future<void> getUser() async {
    setState(() {
      user_loading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userId") ?? "";
    String user_username = prefs.getString("username") ?? "";
    String user_email = prefs.getString("email") ?? "";
    String profile = prefs.getString("profilePicture") ?? "";

    setState(() {
      userId = id;
      email = user_email;
      username = user_username;
      user_loading = false;
      profile_picture = profile;
    });

    print(userId);
    print(email);
    print(username);
    print(profile_picture);
  }

  Future<String> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userId") ?? "";

    await prefs.remove('userId');

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
                  isSaved: data['isSaved'],
                  description: ' ',
                  category: ' ',
                  subcategory: ' ',
                  time: ' ',
                  name: data['username'],
                  avatarImg: data['avatarImg'],
                  bannerImg: data['bannerImg'],
                  location: ' ',
                  likes: data['isLiked'],
                  comments: data['comments'].toString(),
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

  // Verify Dialog
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Are you sure you want to Logout?'),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 110,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: Text('Cancel'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 110,
                      height: 30, // Add some spacing between the buttons
                      child: ElevatedButton(
                        onPressed: () {
                          removeUser();

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // Set the background color
                        ),
                        child: Text('Logout'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
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
                    Icons.thumb_up_outlined,
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
            viewDetailPage1(context, listFeed.feedId.toString(), listFeed);
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
            FontAwesomeIcons.bookmark,
            size: 18,
            color: listFeed.isSaved || saved ? Color(0xFFFF4D4D) : Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () {
            print('Share Tapped');
            // Handle sharing the post here
            // Share.share('https://www.onfocussoft.com');
            Share.shareFiles([listFeed.bannerImg], text: listFeed.description);
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          SizedBox(
            width: 18,
          ),
          Padding(
            padding:
                EdgeInsets.only(right: 24), // Adjust the left padding as needed
            child: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            index: 3,
                          )),
                  (route) => false,
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(profile_picture),
              ),
            ),
          )
        ],
        title: Text("HRA"),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            user_loading
                ? CircularProgressIndicator()
                : DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ), //BoxDecoration
                    child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.white),
                      accountName: Text(
                        username,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      accountEmail: Text(
                        email,
                        style: TextStyle(color: Colors.black),
                      ),
                      currentAccountPictureSize: Size.square(50),
                      currentAccountPicture: GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      index: 3,
                                    )),
                            (route) => false,
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(profile_picture),
                        ),
                      ), //circleAvatar
                    ), //UserAccountDrawerHeader
                  ),

            //DrawerHeader

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.home),
              title: const Text(' Home '),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            index: 1,
                          )),
                  (route) => false,
                );
              },
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            index: 3,
                          )),
                  (route) => false,
                );
              },
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.group),
              title: const Text(' Network Members '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NetworkMembersPage()),
                );
              },
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.school), // Use the certificate icon
              title: const Text(' My certificates '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CertificatePage()),
                );
              },
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.bar_chart_sharp),
              title: const Text(' Events '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventListPage()),
                );
              },
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.image),
              title: const Text(' Gallary '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GalleryPage()),
                );
              },
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.dock),
              title: const Text(' Brochures '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BrochurePage()),
                );
              },
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.panorama_horizontal_select),
              title: const Text(' Training Material '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TrainPage()),
                );
              },
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.article),
              title: const Text(' Articles '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArticlesPage()),
                );
              },
            ),
            /*
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.help),
              title: const Text(' Help '),
              onTap: () {
                Navigator.pop(context);
              },
            ),*/

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                _showConfirmationDialog(context);
              },
            ),
          ],
        ),
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
                : feedListData.length == 0
                    ? Center(
                        child: Text("No posts yet."),
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
                                    feedNewsCardWithImageItem(context, feedItem,
                                        userId, feedItem.likes, username),
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

  Widget viewDetailPage1(context, String postId, Feed feed) {
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
