// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hra/ui/profilePage/followersTab.dart';
import 'package:hra/ui/profilePage/followingTab.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hra/config/app-config.dart';
import 'package:hra/ui/newsFeedPage/widgets/widgetFeed.dart';
import 'package:hra/ui/newsFeedPage/widgets/feedBloc.dart';
import 'package:hra/postpage/postdetail_page.dart';
import 'package:hra/user-registration/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TabController _followersTabController;
  String userId = "";
  String username = "";

  Future<String> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userId") ?? "";

    setState(() {
      userId = id;
      username = prefs.getString("username") ?? "";
    });

    return id;
  }

  Future<String> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userId") ?? "";

    await prefs.remove('userId');

    return id;
  }

  bool loading = false;
  int posts = 0;
  int followers = 0;
  int following = 0;
  bool _isMounted = false;
  List<Feed> feedListData = [];
  List<String> imageList = [];
  bool fetching = false;

  Future<void> fetchStats() async {
    if (!_isMounted) return; // Check if widget is mounted

    setState(() {
      loading = true;
    });

    final response = await http.get(
      Uri.parse(
          '${AppConfig.apiUrl}/socialmedia/api/user-stats?user_id=$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (!_isMounted) return; // Check if widget is mounted

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      if (jsonData['status']) {
        setState(() {
          posts = jsonData['data'][0]['posts'];
          followers = jsonData['data'][0]['followers'];
          following = jsonData['data'][0]['following'];
          loading = false;
        });
      }
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }
    if (_isMounted) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> fetchImages() async {
    if (!_isMounted) return; // Check if widget is mounted
    print("Inside fetch image funtion");
    setState(() {
      loading = true;
    });

    final response = await http.get(
      Uri.parse(
          '${AppConfig.apiUrl}/socialmedia/api/image_list?user_id=$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (!_isMounted) return; // Check if widget is mounted

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print("image list is: ");
      print(jsonData);
      if (jsonData['status']) {
        // Extract image URLs from jsonData and add them to imageList
        final List<dynamic> data = jsonData['data'];
        List<String> images =
            data.map((item) => item['photo_url'] as String).toList();

        setState(() {
          imageList = images;
        });
      }
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }

    if (_isMounted) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> fetchPosts() async {
    setState(() {
      fetching = true;
    });
    final response = await http.get(
      Uri.parse(
          '${AppConfig.apiUrl}/socialmedia/api/user_posts?user_id=$userId'),
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
                  isSaved: data['isSaved'],
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
      fetching = false;
    });
  }

  Future<void> fetchSavedPosts() async {
    setState(() {
      fetching = true;
    });
    final response = await http.get(
      Uri.parse(
          '${AppConfig.apiUrl}/socialmedia/api/saved_posts?user_id=$userId'),
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
                  isSaved: data['isSaved'],
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
      fetching = false;
    });
  }

  void p() async {
    await fetchSavedPosts();
  }

  void p1() {
    print("functionn 2");
  }

  Future<void> initializeData() async {
    await getUser();
    fetchStats();
    fetchPosts();
    // fetchImages();
  }

  List<Widget> widgets = [];
  @override
  void initState() {
    super.initState();
    initializeData();
    _tabController = TabController(length: 4, vsync: this);
    _followersTabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      print('Tab index changed to ${_tabController.index}');

      if (_tabController.index == 3) {
        p();
      } else if (_tabController.index == 1) {
        print("fetching images");
        fetchImages();
      } else {
        p1();
      }
    });

    _isMounted = true; // Widget is mounted
  }

  @override
  void dispose() {
    _tabController.dispose();
    _isMounted = false; // Widget is disposed
    super.dispose();
  }

  Future<void> fetchData() async {
    setState(() {
      loading = true;
    });

    final response = await http.post(
        Uri.parse('${AppConfig.apiUrl}/user/api/stats'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({}));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // User Avatar
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF4D4D),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 140),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/profile.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFFF7F7F7),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Container(
              child: Column(children: [
                /*
                Padding(
                  padding: EdgeInsets.all(2),
                  child: Center(
                    child: Text("Username@email.com",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ),*/
                /*
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Center(
                      child: Text("Designation | Location",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ))),
                ),*/
                Align(
                  alignment: Alignment.topCenter,
                  child: TabBar(
                    controller: _followersTabController,
                    labelColor: Colors.black,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                    labelStyle: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ), // Adjust label font size
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Color(0xFF707070),
                    tabs: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(posts.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text("Posts",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(following.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text("Following",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(followers.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text("Followers",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
            // Tabs
            Expanded(
              child: TabBarView(
                controller: _followersTabController,
                children: [
                  Column(
                    children: <Widget>[
                      loading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              child: TabBar(
                                  controller: _tabController,
                                  labelColor: Colors.black,
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  labelStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                  ), // Adjust label font size
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicatorColor: Color(0xFF707070),
                                  tabs: [
                                    Tab(text: "All Post"),
                                    Tab(text: "Photos"),
                                    Tab(text: "Videos"),
                                    Tab(text: "Saved"),
                                  ]),
                            ),
                      Expanded(
                        child: Container(
                          child: loading
                              ? Center(
                                  child: Container(),
                                )
                              : TabBarView(
                                  controller: _tabController,
                                  children: [
                                      // All Posts
                                      SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            fetching
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Container(
                                                    color: Colors.white,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: feedListData.isEmpty
                                                        ? Center(
                                                            child: Text(
                                                                "No posts yet"),
                                                          )
                                                        : ListView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                                feedListData
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              final feedItem =
                                                                  feedListData[
                                                                      index];
                                                              return GestureDetector(
                                                                onTap: () => viewDetailPage(
                                                                    feedItem
                                                                        .feedId
                                                                        .toString(),
                                                                    feedItem),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <Widget>[
                                                                    feedNewsCardWithImageItem(
                                                                        context,
                                                                        feedItem,
                                                                        userId,
                                                                        feedItem
                                                                            .likes, username),
                                                                    topSpace(),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                  ),
                                          ],
                                        ),
                                      ),

                                      // Photos Tab
                                      SingleChildScrollView(
                                        child: loading
                                            ? CircularProgressIndicator()
                                            : Container(
                                                child: Center(
                                                  child: imageList.isEmpty
                                                      ? Text("No Photos yet.")
                                                      : GridView.builder(
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount:
                                                                3, // Number of columns in the grid
                                                          ),
                                                          itemCount:
                                                              imageList.length,
                                                          shrinkWrap:
                                                              true, // Add this line to limit the height
                                                          physics:
                                                              NeverScrollableScrollPhysics(), // Disable scrolling
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Image
                                                                .network(
                                                              imageList[index],
                                                              fit: BoxFit
                                                                  .cover, // Adjust the BoxFit as needed
                                                            );
                                                          },
                                                        ),
                                                ),
                                              ),
                                      ),

                                      // Videos tab
                                      SingleChildScrollView(
                                        child: Container(
                                          child: Center(
                                              child: Text("No Videos yet.")),
                                        ),
                                      ),

                                      // Saved post tab
                                      SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            fetching
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Container(
                                                    color: Colors.white,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: feedListData.isEmpty
                                                        ? Center(
                                                            child: Text(
                                                                "No saved posts yet"),
                                                          )
                                                        : ListView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                                feedListData
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              final feedItem =
                                                                  feedListData[
                                                                      index];
                                                              return GestureDetector(
                                                                onTap: () => viewDetailPage(
                                                                    feedItem
                                                                        .feedId
                                                                        .toString(),
                                                                    feedItem),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <Widget>[
                                                                    feedNewsCardWithImageItem(
                                                                        context,
                                                                        feedItem,
                                                                        userId,
                                                                        feedItem
                                                                            .likes, username),
                                                                    topSpace(),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ]),
                        ),
                      ),
                    ],
                  ),
                  FollowersTab(),
                  FollowingTab()
                ],
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
