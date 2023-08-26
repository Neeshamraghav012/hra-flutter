import 'package:flutter/material.dart';

class Frame3875 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 390,
          height: 194,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Color(0xFFFF4D4D),
            boxShadow: [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 20,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: 132,
                  height: 132,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/profile.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: OvalBorder(
                      side: BorderSide(width: 1, color: Color(0xFFF7F7F7)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
