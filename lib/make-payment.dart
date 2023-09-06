import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hra/verify-payment.dart';
import 'package:hra/upload-payment.dart';

class PayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Container(
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
                  child: Center(
                    child: Text(
                      "Scan QR Code to pay.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: DottedBorder(
                      color: Color.fromARGB(255, 209, 204, 204),
                      strokeWidth: 3,
                      dashPattern: [10, 6],
                      child: Container(
                          height: 300,
                          width: 230,
                          child: Center(
                            child: Image.asset(
                              'images/qr.jpeg',
                              fit: BoxFit.cover,
                            ),
                          ))),
                ),
                Expanded(
                  child: Center(
                    child:
                        Text("After successfull payment, upload your receipt.",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UploadPaymentPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Color(0xFFFF4D4D),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: Text(
                      'Upload Now',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
