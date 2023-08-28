import 'package:flutter/material.dart';
import 'package:hra/admin.dart';

class Admin extends StatefulWidget {
  final String title;

  const Admin({Key? key, required this.title}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(
            Icons.notifications_active,
            size: 30,
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.account_circle_rounded,
            size: 30,
          ),
        ],
        title: Text(widget.title),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.white),
                accountName: Text(
                  "Raghavendra Maram",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                accountEmail: Text("raghu@squareselect.in", style: TextStyle(color: Colors.black),),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('images/icon.png'),
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(' Dashboard '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.network_locked),
              title: const Text(' Network Members '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart_sharp),
              title: const Text(' Add Events '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text(' Add Images '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.dock),
              title: const Text(' Add Brochures '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.panorama_horizontal_select),
              title: const Text(' Add Training Material '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
                                   ListTile(
              leading: const Icon(Icons.article),
              title: const Text(' Add Articles '),
              onTap: () {
                Navigator.pop(context);
              },
            ),

                                   ListTile(
              leading: const Icon(Icons.branding_watermark),
              title: const Text(' Add Banners '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text(' Help '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(children: [
        Profiles(
          name: "Pranai Kumar",
          info: "Onfocus soft \nRef: Prasad Kotha",
        ),
        Profiles(
          name: "Kathryn Murphy",
          info: "Squareselect\nRef: Prasad Kotha",
        ),
        Profiles(
          name: "Pranai Kumar",
          info: "Onfocus soft \nRef: Prasad Kotha",
        ),
        Profiles(
          name: "Floyd Miles",
          info: "Squareselect\nRef: Eleanor Pena",
        ),
      ]),
    );
  }
}

class Profiles extends StatelessWidget {
  final String name;
  final String info;

  const Profiles({
    Key? key,
    required this.name,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 25),
      child: Container(
        width: 341,
        height: 84,
        decoration: ShapeDecoration(
          color: Color(0xFFF5FBFC),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.50, color: Color(0xFFE6EBF0)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(children: [
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(30), // Set the desired corner radius
              child: Container(
                width: 57,
                height: 57,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/icon.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: Column(
              children: [
                SizedBox(
                  width: 139,
                  height: 24,
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 1.33,
                    ),
                  ),
                ),
                SizedBox(
                  width: 139,
                  height: 32,
                  child: Text(
                    info,
                    style: TextStyle(
                      color: Color(0xFF55595E),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 5),
              child: ElevatedButton(
                onPressed: () {

                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Frame3875 ()),
                              );


                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30), // Adjust the value for the desired corner radius
                  ),
                  backgroundColor: Color(0xFF2A2A2A),
                  padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10), // Change the color to your desired color
                ),
                child: Text(
                  'View Profile',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white, // Text color
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
