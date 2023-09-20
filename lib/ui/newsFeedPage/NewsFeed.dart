import 'package:flutter/material.dart';
import 'package:hra/postpage/postdetail_page.dart';
import 'package:hra/ui/newsFeedPage/widgets/feedBloc.dart';
import 'package:hra/ui/newsFeedPage/widgets/widgetFeed.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hra/config/app-config.dart';
import 'package:hra/user-registration/login.dart';
import 'package:hra/ui/home.dart';
import 'package:hra/admin/Articles.dart';
import 'package:hra/admin/Gallery.dart';
import 'package:hra/admin/Event-list.dart';
import 'package:hra/admin/Network.dart';
import 'package:hra/admin/training-material.dart';
import 'package:hra/admin/brochures.dart';

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

  Future<void> getUser() async {
    setState(() {
      user_loading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userId") ?? "";
    String user_username = prefs.getString("username") ?? "";
    String user_email = prefs.getString("email") ?? "";

    setState(() {
      userId = id;
      email = user_email;
      username = user_username;
      user_loading = false;
    });

    print(userId);
    print(email);
    print(username);
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
            padding: EdgeInsets.only(
                right: 16.0), // Adjust the left padding as needed
            child: Icon(
              Icons.account_circle_rounded,
              size: 30,
            ),
          ),
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
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('images/icon.png'),
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
                  MaterialPageRoute(builder: (context) => HomePage()),
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
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false,
                );
              },
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.network_locked),
              title: const Text(' Network Members '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NetworkPage()),
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
                  MaterialPageRoute(builder: (context) => EventPage1()),
                );
              },
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.image),
              title: const Text(' Images '),
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
                  MaterialPageRoute(builder: (context) => BroPage()),
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
                  MaterialPageRoute(builder: (context) => ArtPage()),
                );
              },
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.help),
              title: const Text(' Help '),
              onTap: () {
                Navigator.pop(context);
              },
            ),

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
                                    feedNewsCardWithImageItem(
                                        context, feedItem, userId, feedItem.likes),
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
