import 'package:flutter/material.dart';
import 'package:hra/social.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:hra/ui/home.dart';
import 'package:hra/home.dart';
import 'package:hra/admin/admin0.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.grey,
          accentColor: Color(0xFFFF4D4D),
          fontFamily: 'Poppins'),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userId = "";

  Future<String> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userId") ?? "";

    setState(() {
      userId = id;
    });
    return id;
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    const splashDuration = Duration(seconds: 2);

    Future.delayed(splashDuration, () {
      print(userId);
      if (userId != "") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Admin(title: 'HRA',),
          ),
        );
        return;
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
