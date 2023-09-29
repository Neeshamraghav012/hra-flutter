import 'package:flutter/material.dart';

class NetworkMembersPage extends StatefulWidget {
  @override
  State<NetworkMembersPage> createState() => _NetworkPageMembersState();
}

class _NetworkPageMembersState extends State<NetworkMembersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Network Members",
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
          /*Container(
            margin: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/pp.jpg'),
              radius: 20,
            ),
          ),*/
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
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
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < 7; i++)
                      Members(), // Use a loop to create multiple members
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
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
          ],
        ),
      ),
    );
  }

  Padding Members() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2, // Add elevation for a shadow effect
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 42.5, // Half of the desired width/height
                      backgroundImage: AssetImage("images/icon.png"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30), // Adjust the value for the desired corner radius
                        ),
                        backgroundColor: Color(0xFFFF4D4D),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical:
                                2), // Change the color to your desired color
                      ),
                      child: Text(
                        'View Profile',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white, // Text color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.0), // Add spacing between the avatar and text
              Padding(
                padding: EdgeInsets.only(left: 10, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Raghavendra Maram",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Secretary",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "abc123455@gmail.com",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Hyderabad",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.phone),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.message),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
