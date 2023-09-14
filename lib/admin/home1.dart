import 'package:flutter/material.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   @override
//   Size get preferredSize => Size.fromHeight(100);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Color(0xFFFF4D4D),
//       elevation: 0,
//     );
//   }
// }

class Home1Page extends StatefulWidget {
  @override
  State<Home1Page> createState() => _Home1State();
}

class _Home1State extends State<Home1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Home",
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
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
    );
  }
}
