import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hra/admin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hra/login.dart';
import 'package:hra/app-config.dart';

class Admin extends StatefulWidget {
  final String title;

  const Admin({Key? key, required this.title}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class UserData {
  final String id;
  final String username;
  String? establishment;

  UserData({
    required this.id,
    required this.username,
    this.establishment,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      username: json['username'],
      establishment: json['establishment'],
    );
  }
}

class _AdminState extends State<Admin> {
  List<UserData> usersData = [
    UserData(username: "JohnDoe", id: "1noajr", establishment: "ABC Company")
  ];
  bool loading = false;

  Future<void> fetchUsers() async {
    setState(() {
      loading = true;
    });
    final response =
        await http.get(Uri.parse('${AppConfig.apiUrl}/user/api/user-list'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<dynamic> apiData = jsonData['data'];

      usersData = apiData.map((userDataMap) {
        return UserData(
            username: userDataMap["username"],
            id: userDataMap['id'],
            establishment: userDataMap['establishment']);
      }).toList();

      print(usersData);
      setState(() {
        loading = false;
      });
    } else {
      print('API request failed with status code:');
      setState(() {
        loading = false;
      });
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();

        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            actions: [
              Icon(
                Icons.notifications_active,
                size: 30,
              ),
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
            title: Text(widget.title),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          drawer: Drawer(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ), //BoxDecoration
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.white),
                    accountName: Text(
                      "Raghavendra Maram",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    accountEmail: Text(
                      "raghu@squareselect.in",
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
                  title: const Text(' Dashboard '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Icon(Icons.person),
                  title: const Text(' My Profile '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Icon(Icons.network_locked),
                  title: const Text(' Network Members '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Icon(Icons.bar_chart_sharp),
                  title: const Text(' Add Events '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Icon(Icons.image),
                  title: const Text(' Add Images '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Icon(Icons.dock),
                  title: const Text(' Add Brochures '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Icon(Icons.panorama_horizontal_select),
                  title: const Text(' Add Training Material '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Icon(Icons.article),
                  title: const Text(' Add Articles '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Icon(Icons.branding_watermark),
                  title: const Text(' Add Banners '),
                  onTap: () {
                    Navigator.pop(context);
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
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
          body: loading
              ? Center(child: CircularProgressIndicator())
              : usersData.length == 0
                  ? Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Center(child: Text("No unverified profiles")),
                      ),
                    )
                  : ListView.builder(
                      itemCount: usersData.length,
                      itemBuilder: (BuildContext context, int index) {
                        final myObject = usersData[index];
                        return Profiles(
                          name: myObject.username,
                          info: myObject.establishment ?? "Individual",
                          user_id: myObject.id,
                        );
                      },
                    )),
    );
  }
}

class Profiles extends StatelessWidget {
  final dynamic name;
  final dynamic info;
  final dynamic user_id;

  const Profiles({
    Key? key,
    required this.name,
    required this.user_id,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Container(
          width: 341,
          height: 84,
          decoration: ShapeDecoration(
            color: Color(0xFFF5FBFC),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.50, color: Color(0xFFE6EBF0)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(children: [
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 57,
                  height: 57,
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
                  SizedBox(
                    width: 139,
                    height: 24,
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 1.33,
                      ),
                      overflow: TextOverflow
                          .ellipsis, // Add this line to indicate text overflow
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    width: 139,
                    height: 32,
                    child: Text(
                      info ?? "Individual",
                      style: TextStyle(
                        color: Color(0xFF55595E),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                      overflow: TextOverflow
                          .ellipsis, // Add this line to indicate text overflow
                      maxLines: 1,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: 103,
                height: 32,
                child: Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Frame3875(
                            user_id: user_id,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            30), // Adjust the value for the desired corner radius
                      ),
                      backgroundColor: Color(0xFF2A2A2A),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical:
                              10), // Change the color to your desired color
                    ),
                    child: Text(
                      'View Profile',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white, // Text color
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
