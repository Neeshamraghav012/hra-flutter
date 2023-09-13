import 'package:flutter/material.dart';

class CertPage extends StatefulWidget {
  @override
  State<CertPage> createState() => _CertState();
}

class _CertState extends State<CertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Certificate",
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
            SizedBox(height: 5), // Add spacing between the image and the column
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      width: 342,
                      height: 53,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color.fromRGBO(245, 251, 252, 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'images/ii.jpg', // Replace with the path to your image
                              width: 26, // Adjust the width as needed
                              height: 22, // Adjust the height as needed
                            ),
                            SizedBox(width: 20),
                            Text(
                              "View ID CARD",
                              style: const TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                height: 24 / 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 152),
                            GestureDetector(
                              onTap: () {
                                // Add your download functionality here
                              },
                              child: Image.asset(
                                  'images/download.jpg'), // Replace with your image asset path
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Add more widgets as needed
              ],
            ),

            //SizedBox(height: 5), // Add spacing between the image and the column
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Container(
                      width: 342,
                      height: 53,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color.fromRGBO(245, 251, 252, 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'images/ii.jpg', // Replace with the path to your image
                              width: 26, // Adjust the width as needed
                              height: 22, // Adjust the height as needed
                            ),
                            SizedBox(width: 20),
                            Text(
                              "View Membership Certificate",
                              style: const TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                height: 24 / 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 58),
                            GestureDetector(
                              onTap: () {
                                // Add your download functionality here
                              },
                              child: Image.asset(
                                  'images/download.jpg'), // Replace with your image asset path
                            ),
                          ],
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
