import 'package:flutter/material.dart';
import 'package:hra/Aricles1.dart';
import 'package:hra/Articles.dart';
import 'package:hra/Events.dart';
import 'package:hra/Events1.dart';
import 'package:hra/Gallery.dart';
import 'package:hra/brochures.dart';
import 'package:hra/certificate.dart';
import 'package:hra/login.dart';
import 'package:hra/home.dart';
import 'package:hra/admin.dart';
import 'package:hra/signup.dart';
import 'package:hra/social.dart';
import 'package:hra/training-material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<String> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userId") ?? "";
    return id;
  }

  late Future<String> userId;

  @override
  void initState() {
    setState(() {
      userId = getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const splashDuration = Duration(seconds: 2);

    Future.delayed(splashDuration, () {
      if (userId != "") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SocialPage(
                    user_id: userId.toString(),
                  )),
        );
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/logo.jpg', // Replace with your image asset path
                  width: 200, // Set the image width
                  height: 200, // Set the image height
                ),
              ],
            ),
          ),
          //SizedBox(height: 1),
          //Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'Powered by OnFocus Software Pvt. Ltd',
              style: TextStyle(
                fontSize: 11.600000381469727,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                height: 17 / 11.600000381469727,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
