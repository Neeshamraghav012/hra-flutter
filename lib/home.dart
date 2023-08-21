import 'package:flutter/material.dart';
import 'package:hra/login.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize =>
      Size.fromHeight(100); // Set the desired height of the custom app bar

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage('images/appbar.jpg'), // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
      child: AppBar(
        title: Text('App Title'),
        backgroundColor:
            Colors.transparent, // Make the app bar background transparent
        elevation: 0, // Remove the shadow
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'images/bg.jpg'), // Replace with your background image path
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.transparent, // Transparent color
                        BlendMode.dstATop, // Blend mode to apply transparency
                      ),
                      child: Image(
                        image: AssetImage('images/home.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Welcome to HRA',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20, // Increase font size
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Together We Can Grow',
                  style: TextStyle(
                    color: Colors.grey[700], // Slightly lighter text color
                    fontSize: 16, // Increase font size
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "“ Our GOAL is to set the best ethical standards and practices in the field of real estate consulting and nothing less. “",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign
                        .center, // Align the text content to the center
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Perform password reset logic here

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginPage()), // Replace with your signup screen
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      primary: Color(0xFFFF4D4D), // Change the button color
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                    ),
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        fontSize: 18, // Increase font size
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
