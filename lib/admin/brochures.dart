import 'package:flutter/material.dart';

class BrochurePage extends StatefulWidget {
  @override
  State<BrochurePage> createState() => _BroState();
}

class _BroState extends State<BrochurePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Brochures",
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

            SizedBox(height: 5), // Add spacing between the image and the column
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 4),
                    child: Container(
                      width: 370,
                      height: 55,
                      // child: Padding(
                      //   padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Add your download functionality here
                            },
                            child: Container(
                              width: 50, // Increase the width
                              height: 50, // Increase the height
                              child: Image.asset(
                                'images/dow.jpg',
                                fit: BoxFit
                                    .cover, // You can use BoxFit to control how the image fits within the container
                              ),
                            ), // Replace with your image asset path
                          ),
                          SizedBox(width: 20),
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Brochure name\n\n",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo con",
                                    style: const TextStyle(
                                      fontSize:
                                          9, // Change the font size for the remaining text
                                      fontWeight: FontWeight
                                          .w400, // Use a different font weight if needed
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //),
                  ),
                ),
              ],
            ),
            Container(
              width: 340, // Adjust the width of the divider as needed
              child: Divider(
                color: Color.fromARGB(255, 156, 151, 151),
                thickness: 0.0,
              ),
            ),
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 0),
                    child: Container(
                      width: 370,
                      height: 55,
                      // child: Padding(
                      //   padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Add your download functionality here
                            },
                            child: Container(
                              width: 50, // Increase the width
                              height: 50, // Increase the height
                              child: Image.asset(
                                'images/dow.jpg',
                                fit: BoxFit
                                    .cover, // You can use BoxFit to control how the image fits within the container
                              ),
                            ), // Replace with your image asset path
                          ),
                          SizedBox(width: 20),
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Brochure name\n\n",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore ",
                                    style: const TextStyle(
                                      fontSize:
                                          9, // Change the font size for the remaining text
                                      fontWeight: FontWeight
                                          .w400, // Use a different font weight if needed
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //),
                  ),
                ),
              ],
            ),
            Container(
              width: 340, // Adjust the width of the divider as needed
              child: Divider(
                color: Color.fromARGB(255, 156, 151, 151),
                thickness: 0.0,
              ),
            ),
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 0),
                    child: Container(
                      width: 370,
                      height: 55,
                      // child: Padding(
                      //   padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Add your download functionality here
                            },
                            child: Container(
                              width: 50, // Increase the width
                              height: 50, // Increase the height
                              child: Image.asset(
                                'images/dow.jpg',
                                fit: BoxFit
                                    .cover, // You can use BoxFit to control how the image fits within the container
                              ),
                            ), // Replace with your image asset path
                          ),
                          SizedBox(width: 20),
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Brochure name\n\n",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo con",
                                    style: const TextStyle(
                                      fontSize:
                                          9, // Change the font size for the remaining text
                                      fontWeight: FontWeight
                                          .w400, // Use a different font weight if needed
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //),
                  ),
                ),
              ],
            ),
            Container(
              width: 340, // Adjust the width of the divider as needed
              child: Divider(
                color: Color.fromARGB(255, 156, 151, 151),
                thickness: 0.0,
              ),
            ),
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      width: 370,
                      height: 55,
                      // child: Padding(
                      //   padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Add your download functionality here
                            },
                            child: Container(
                              width: 50, // Increase the width
                              height: 50, // Increase the height
                              child: Image.asset(
                                'images/dow.jpg',
                                fit: BoxFit
                                    .cover, // You can use BoxFit to control how the image fits within the container
                              ),
                            ), // Replace with your image asset path
                          ),
                          SizedBox(width: 20),
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Brochure name\n\n",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo con",
                                    style: const TextStyle(
                                      fontSize:
                                          9, // Change the font size for the remaining text
                                      fontWeight: FontWeight
                                          .w400, // Use a different font weight if needed
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //),
                  ),
                ),
              ],
            ),
            Container(
              width: 340, // Adjust the width of the divider as needed
              child: Divider(
                color: Color.fromARGB(255, 156, 151, 151),
                thickness: 0.0,
              ),
            ),
            Column(
              children: [
                Center(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 160, bottom: 4),
                    child: Container(
                      width: 342,
                      height: 68, // Adjust the height as needed
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage('images/ad1.jpg'),
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
      ),
    );
  }
}