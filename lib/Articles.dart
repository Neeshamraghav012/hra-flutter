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
            //SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(
                  8.0), // Add spacing between the images and the container above
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Align images at the ends
                children: [
                  Container(
                    width: 163,
                    padding:
                        EdgeInsets.all(8.0), // Adjust the padding as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/media.jpg',
                          width: 163,
                          height: 107,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Understand The Real Estate Market Analysis",
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Real estate is a diverse sector encompassing various physical properties, such as land, buildings, and structures.",
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 7,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff3c4042),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "2022-06-08",
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 7,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff1e1e1e),
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 163,
                    padding:
                        EdgeInsets.all(8.0), // Adjust the padding as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/media1.jpg',
                          width: 163,
                          height: 107,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Real Estate Sector To Benefit From RBI’s Eased Norms",
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff14303c),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "The Reserve Bank of India (RBI) recently announced its bi-monthly monetary policy statement, which had some good news",
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 7,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff3c4042),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "2022-06-08",
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 7,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff1e1e1e),
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(
                  8.0), // Add spacing between the images and the container above
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Align images at the ends
                children: [
                  Container(
                    width: 163,
                    padding:
                        EdgeInsets.all(8.0), // Adjust the padding as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/media2.jpg',
                          width: 163,
                          height: 107,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Telangana Mobility Valley",
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Telangana, the second largest state in India, is witnessing remarkable growth in the automotive engineering and research sector.",
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 7,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff3c4042),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "2022-06-08",
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 7,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff1e1e1e),
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 163,
                    padding:
                        EdgeInsets.all(8.0), // Adjust the padding as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/media3.jpg',
                          width: 163,
                          height: 107,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "GMR AeroCity",
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff14303c),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "GMR AeroCity envisions a dynamic and varied environment where workplaces, retail stores, recreational areas, hospitality choices",
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 7,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff3c4042),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "2022-06-08",
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 7,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff1e1e1e),
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
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
