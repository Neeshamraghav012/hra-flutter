import 'package:flutter/material.dart';

class ArtPage1 extends StatefulWidget {
  @override
  State<ArtPage1> createState() => _Art1State();
}

class _Art1State extends State<ArtPage1> {
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
          //crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: 16),
            // Add some space between the two images
            Padding(
              padding:
                  const EdgeInsets.all(16.0), // Adjust the padding as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 341,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        // borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage(
                              'images/media4.jpg'), // Replace with your image path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 8), // Add some space between the image and text
                  Text(
                    "Understand The Real Estate Market Analysis",
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff14303c),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "on the future of ticketing systems. Honed over time, combined with research, experience, and an eye for the best possible future state of support, we think you’ll be interested in knowing these perspectives of modern ticketing.on the future of ticketing systems. Honed over time, combined with research, experience, and an eye for the best possible future state of support, we think you’ll be interested in knowing these perspectives of modern ticketing.",
                    style: const TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000),
                      //height: 244 / 14,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            )

            // ],
            // )
          ],
        ),
      ),
    );
  }
}
