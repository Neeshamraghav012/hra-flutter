import 'package:flutter/material.dart';


class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40); // Adjust points to define your shape
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(
        3 * size.width / 4, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class StyledVectorTop extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: ClipPath(
        clipper:
            CustomClipPath(), // Create a custom clipper to define the vector shape
        child: Container(
          height: 200, // Adjust the height according to your design
          color: Color(0xFFFF4D4D), // Set the color of the vector
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(200); // Set the preferred height of the AppBar
}
