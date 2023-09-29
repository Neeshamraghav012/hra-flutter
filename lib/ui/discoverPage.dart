import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hra/config/app-config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<DiscoverPage> {
  String userId = "";
  bool clicked = false;
  bool loading = false;
  bool isfollowing = false;

  Future<String> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userId") ?? "";

    setState(() {
      userId = id;
    });

    return id;
  }

  Future<void> initializeData() async {
    await getUser();
    fetchPeople();
  }

  List<Map<String, dynamic>> peopleData = [];

  Future<void> fetchPeople() async {
    setState(() {
      loading = true;
    });
    final response = await http.get(
      Uri.parse('${AppConfig.apiUrl}/socialmedia/api/discover?user_id=$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      if (jsonData['status']) {
        setState(() {
          // Explicitly cast jsonData['data'] to List<Map<String, dynamic>>
          peopleData = (jsonData['data'] as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();

          loading = false;
        });
      }
    } else {
      setState(() {
        loading = false;
      });
      print('API request failed with status code: ${response.statusCode}');
    }
  }

  Future<void> follow(String following_id, int index) async {
    setState(() {
      isfollowing = true;
    });
    final response = await http.post(
        Uri.parse('${AppConfig.apiUrl}/socialmedia/api/follow?user_id=$userId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "follow_input": {
            "created_by": userId,
            "updated_by": userId,
            "following_id": following_id,
            "follower_id": userId
          }
        }));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      if (jsonData['status']) {
        setState(() {
          peopleData.removeAt(index);
          isfollowing = false;
        });
      }
    } else {
      setState(() {
        isfollowing = false;
      });
      print('API request failed with status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    print("hello");
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discover people',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 75,
        automaticallyImplyLeading: false,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60),
            bottomRight: Radius.circular(56),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13, left: 4, right: 17),
            child: Container(
              width: 369,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: peopleData.length,
                  itemBuilder: (context, index) {
                    final peopleItem = peopleData[index];
                    return Follow(
                        peopleItem['username'], peopleItem['user_id'], index, peopleItem['avatarImg']);
                  },
                ),
        ],
      ),
    );
  }

  Center Follow(String username, String user_id, int index, String avatarImg) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 14, left: 5, right: 17),
        child: Container(
          padding: EdgeInsets.only(top: 9, left: 11, right: 11, bottom: 9),
          width: 369,
          height: 66,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.50, color: Color(0xFFE6EBF0)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(avatarImg),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 13),
                child: Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "$username\n",
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff000000),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "",
                            style: const TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff000000),
                              //height: 20 / 14,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              )
            ]),

            Container(
              width: 84,
              height: 28,
              child: Padding(
                padding: EdgeInsets.only(right: 0),
                child: ElevatedButton(
                  onPressed: () {
                    var snackdemo = SnackBar(
                      content: Text("You started following $username"),
                      backgroundColor: Colors.green,
                      elevation: 10,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(5),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                    follow(user_id, index);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 1,
                      vertical: 5,
                    ),
                  ),
                  child: Text(
                    "Follow +",
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            // ),
          ]),
        ),
      ),
    );
  }
}
