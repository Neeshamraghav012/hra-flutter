import 'package:flutter/material.dart';

class MembershipPage1 extends StatefulWidget {
  @override
  _Membership1State createState() => _Membership1State();
}

class _Membership1State extends State<MembershipPage1> {
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
              Image.asset(
                'images/membership.png',
                height: 200, // Adjust the height as needed
              ),
              SizedBox(height: 27.17),
              const Text(
                'Your request for member\n'
                'verification has been successfully\n '
                'processed.',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff252525),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.8),
              Container(
                width: 328, // Adjust the width of the divider as needed
                child: Divider(
                  color: Color.fromARGB(255, 156, 151, 151),
                  thickness: 1.0,
                ),
              ),
              SizedBox(height: 12.8),
              Text(
                "Complete payment to become a\n"
                "member.",
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff252525),
                  //height: 50/16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 44.8),
              ElevatedButton(
                  onPressed: () {
                    // Add your payment logic here
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 11,
                    ),
                  ),
                  child: Text(
                    "PAY NOW",
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 20 / 16,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ]),
          ],
        ),
      ),
    );
  }
}
