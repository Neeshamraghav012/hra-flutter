import 'package:flutter/material.dart';


class PayPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4D4D),
        elevation: 0,
        toolbarHeight: 100,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 105, bottom: 27.8),
        child: ListView(children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'images/pay.jpg',
              width: 310,
              height: 223, // Adjust the height as needed
            ),
            SizedBox(height: 55.31),
            Text(
              "Please wait!",
              style: const TextStyle(
                fontFamily: "Roboto",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Color(0xff252525),
                //height: 23 / 24,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 27.4),
            Text(
              "Your payment verification is\n"
              "under process.",
              style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xff252525),
                //height: 50 / 16,
              ),
              textAlign: TextAlign.center,
            ),
          ]),
        ]),
      ),
    );
  }
}
