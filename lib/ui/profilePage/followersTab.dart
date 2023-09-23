import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hra/config/app-config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FollowersTab extends StatefulWidget {
  @override
  _FollowersTabState createState() => _FollowersTabState();
}

class _FollowersTabState extends State<FollowersTab> {
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
    return Container(
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: height*0.01),
            child: Text(
              'People you follow',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: height*0.025 ),
            ),
          ),
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
                        peopleItem['username'], peopleItem['user_id'], index);
                  },
                ),
        ],
      ),
    );
  }

  Center Follow(String username, String user_id, int index) {
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
                        image: AssetImage("images/icon.png"),
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
