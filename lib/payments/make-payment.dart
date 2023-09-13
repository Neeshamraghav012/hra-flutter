
import 'package:flutter/material.dart';
import 'package:hra/payments/upload-payment.dart';

class PayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4D4D),
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 107, left: 29, right: 30),
          child: Container(
            width: 334,
            height: 504,
            //padding: EdgeInsets.only(top: 41, left: 23, right: 23),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 41, left: 75, right: 23),
                    child: Container(
                      width: 285,
                      height: 27,
                      // child: Padding(
                      //   padding: EdgeInsets.only(left: 52, right: 23),
                      child: Text(
                        "Scan QR Code to pay.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  //),
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  child: Container(
                      height: 220,
                      width: 224,
                      child: Center(
                        child: Image.asset(
                          'images/qr.jpeg',
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 41,
                          right: 40), // You can adjust the padding as needed
                      child: Text(
                        "After successful payment, upload\n"
                        "                  your receipt.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Container(
                      width: 180, // Set your desired width
                      height: 40, // Set your desired height
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadPaymentPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.black,
                        ),
                        child: Text(
                          'Upload Now',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
