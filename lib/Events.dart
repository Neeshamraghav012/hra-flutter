import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  @override
  State<EventPage> createState() => _EventState();
}

class _EventState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Events",
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
            SizedBox(height: 5),
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
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Event name",
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Date: 01/05/2021",
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  // Add some space between the image and text
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Event description\n\n",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              "on the future of ticketing systems. Honed over time, combined with research, experience, and an eye for the best possible future state of support, we think you’ll be interested in knowing these perspectives of modern ticketing.on the future of ticketing systems. Honed over time, combined with research, experience, and an eye for the best possible future state of support, we think you’ll be interested in knowing these perspectives of modern ticketing.",
                          style: const TextStyle(
                            fontSize:
                                14, // Change the font size for the remaining text
                            fontWeight: FontWeight
                                .w400, // Use a different font weight if needed
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                  Text(
                    "Location",
                    style: const TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Full address",
                    style: const TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      //height: 244 / 14,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
