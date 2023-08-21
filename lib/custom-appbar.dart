import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize =>
      Size.fromHeight(100); // Set the desired height of the custom app bar

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage('images/appbar.jpg'), // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
      child: AppBar(
        title: Text('HRA'),
        backgroundColor:
            Colors.transparent, // Make the app bar background transparent
        elevation: 0, // Remove the shadow
      ),
    );
  }
}
