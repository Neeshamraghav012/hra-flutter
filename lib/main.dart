import 'package:flutter/material.dart';
import 'package:hra/login.dart';
import 'package:hra/home.dart';
import 'package:hra/admin.dart';

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

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        const splashDuration = Duration(seconds: 2);

    // Navigating to the next screen after the delay
    Future.delayed(splashDuration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Replace with your desired screen
      );
    });
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.jpg', // Replace with your image asset path
              width: 200, // Set the image width
              height: 200, // Set the image height
            ),
            SizedBox(height: 200),
          Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Powered by OnFocus Software Pvt. Ltd',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
