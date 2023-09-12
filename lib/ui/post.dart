import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create a post",
          style: const TextStyle(
            fontFamily: "Lato",
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0xff5b5b5b),
            //height: 25/20,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        leading: GestureDetector(
          onTap: () {
            // Add navigation functionality here
          },
          child: Image.asset(
            'images/cross.jpg', // Replace with the path to your image asset
            width: 24, // Adjust the width as needed
            height: 24, // Adjust the height as needed
            //color: Colors.black, // Adjust the color as needed
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                right: 16.0), // Adjust the padding as needed
            child: Center(
              child: Text(
                "Post",
                style: const TextStyle(
                  fontFamily: "Lato",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                  height: 22 / 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              width: 342,
              child: Divider(
                color: Colors.grey, // Adjust the color as needed
                thickness: 1, // Adjust the thickness as needed
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'images/s.jpg', // Replace with your image path
                      width: 44, // Set the width as per your requirements
                      height: 44, // Set the height as per your requirements
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 17),
                    Text(
                      "What's on your mind, Pranai?",
                      style: const TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff99a1be),
                        //height: 18/15,
                      ),
                      //textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
