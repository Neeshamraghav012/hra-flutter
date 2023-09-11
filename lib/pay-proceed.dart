import 'package:flutter/material.dart';
import 'package:hra/verify-payment.dart';
import 'package:hra/upload-payment.dart';
import 'package:hra/make-payment.dart';

class ProceedPage extends StatefulWidget {
  @override
  _ProceedState createState() => _ProceedState();
}

class _ProceedState extends State<ProceedPage> {
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
        child: ListView(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Thank you!",
                style: const TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff252525),
                  height: 23 / 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "You are now a member",
                style: const TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff252525),
                  height: 23 / 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 17.8),
              Image.asset(
                'images/pay2.jpg',
                width: 310,
                height: 223, // Adjust the height as needed
              ),
              SizedBox(height: 17),
              Text(
                "Your request has been successfully\n"
                "confirmed and processed.",
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff252525),
                  //height: 42/16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.17),
              ElevatedButton(
                  onPressed: () {
                    // Add your payment logic here
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 11,
                    ),
                  ),
                  child: Text(
                    "PROCEED",
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 20 / 16,
                    ),
                    textAlign: TextAlign.left,
                  )),
            ]),
          ],
        ),
      ),
    );
  }
}
