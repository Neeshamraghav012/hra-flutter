import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hra/ui/home.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  String profile_picture = '';

  Future<void> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String profile = prefs.getString("profilePicture") ?? "";

    setState(() {
      profile_picture = profile;
    });

    print("profile picture is: ");
    print(profile_picture);
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Notification',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 2,
          toolbarHeight: 75,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60), // Adjust the radius as needed
              bottomRight: Radius.circular(60), // Adjust the radius as needed
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.menu),
            color: Colors.black,
            onPressed: () {
              //Navigator.pop(context); // Add navigation functionality here
            },
          ),
          actions: [
            GestureDetector(
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
              child: Container(
                margin: EdgeInsets.all(8.0), // Adjust margin as needed
                child: CircleAvatar(
                  backgroundImage: profile_picture != ''
                      ? NetworkImage(profile_picture)
                      : AssetImage('images/pp.jpg') as ImageProvider<Object>,
                  radius:
                      20, // Adjust the radius to control the size of the circle
                ),
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Text("No Notifications yet."),
        ));
  }
}
