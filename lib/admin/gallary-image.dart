import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GalleryImagePage extends StatelessWidget {
  final String image;

  GalleryImagePage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Gallery",
          style: TextStyle(
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
          /*
          Container(
            margin: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/pp.jpg'),
              radius: 20,
            ),
          ),*/
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              width: 342,
              height: 68,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage('images/ad.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0), // Adjust the padding values as needed
              child: Image.asset(
                'images/$image.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                  child: Container(
                    width: 342,
                    height: 68, // Adjust the height as needed
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('images/ad.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
