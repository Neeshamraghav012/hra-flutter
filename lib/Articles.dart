import 'package:flutter/material.dart';

class ArtPage extends StatefulWidget {
  @override
  State<ArtPage> createState() => _ArtState();
}

class _ArtState extends State<ArtPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Articles",
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            height: 24 / 16,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(8.0), // Adjust margin as needed
            child: CircleAvatar(
              backgroundImage: AssetImage('images/pp.jpg'),
              radius: 20, // Adjust the radius to control the size of the circle
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16.0), // Adjust the top padding as needed
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 342,
                height: 68,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage(
                        'images/adssss.jpg'), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.all(
                  16.0), // Add spacing between the images and the container above
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Align images at the ends
                children: [
                  Image.asset(
                    'images/media.jpg',
                    width: 163,
                    height: 107,
                  ),
                  //SizedBox(width: 5), // Replace with your first image path
                  Image.asset(
                      'images/media1.jpg'), // Replace with your second image path
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
