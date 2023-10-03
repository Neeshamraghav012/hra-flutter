import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hra/config/app-config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hra/ui/profilePage/user-profile.dart';

class FollowingTab extends StatefulWidget {
  @override
  _FollowingTabState createState() => _FollowingTabState();
}

class _FollowingTabState extends State<FollowingTab> {
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
      Uri.parse(
          '${AppConfig.apiUrl}/socialmedia/api/following?user_id=$userId'),
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

  @override
  void initState() {
    print("hello");
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: height * 0.01),
          child: Text(
            'All followers',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: height * 0.025),
          ),
        ),
        loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : peopleData.isEmpty
                ? Center(
                    child: Text("No followers yet."),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (int i = 0; i < peopleData.length; i++)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserProfile(
                                      user_id: peopleData[i]['user_id'],
                                    ),
                                  ),
                                );
                              },
                              child: Follow(
                                  peopleData[i]['username'],
                                  peopleData[i]['user_id'],
                                  i,
                                  peopleData[i]['avatarImg']),
                            ),
                        ],
                      ),
                    ),
                  ),
      ],
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
                        image: avatarImg.isEmpty
                            ? AssetImage('images/icon.png')
                            : NetworkImage(avatarImg) as ImageProvider,
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

            // ),
          ]),
        ),
      ),
    );
  }
}
