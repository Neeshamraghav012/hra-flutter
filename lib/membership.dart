import 'package:flutter/material.dart';
import 'package:hra/verify-payment.dart';
import 'package:hra/upload-payment.dart';
import 'package:hra/make-payment.dart';

class MembershipPage extends StatefulWidget {
  @override
  _MembershipState createState() => _MembershipState();
}

class _MembershipState extends State<MembershipPage> {
  bool isNetworkMemberSelected = false;
  bool isNetworkMemberSelected1 = false; // Track checkbox state
  bool isNetworkMemberSelected2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 105, bottom: 27.8),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                Text(
                  'Choose membership',
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff252525),
                    height: 26 / 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.17),
                Container(
                  width: 328,
                  height: 61,

                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ]), // Adjust padding as needed
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'Network Member\n',
                          style: const TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000000),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '4000 INR',
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff000000),
                                height: 20 / 14,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: 140),
                      Checkbox(
                        value:
                            isNetworkMemberSelected, // Change the initial value as needed
                        onChanged: (bool? value) {
                          setState(() {
                            isNetworkMemberSelected = value ?? false;
                            isNetworkMemberSelected1 = false;
                            isNetworkMemberSelected2 = false;
                          });
                          // Handle checkbox state change here
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22),
                Container(
                  width: 328,
                  height: 61,

                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ]), // Adjust padding as needed
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'Professinal Member\n',
                          style: const TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000000),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '25,000 INR',
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff000000),
                                height: 20 / 14,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: 119),
                      Checkbox(
                        value:
                            isNetworkMemberSelected1, // Change the initial value as needed
                        onChanged: (bool? value) {
                          setState(() {
                            isNetworkMemberSelected1 = value ?? false;
                            isNetworkMemberSelected = false;
                            isNetworkMemberSelected2 = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22),
                Container(
                  width: 328,
                  height: 61,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ]),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'Corporate Member\n',
                          style: const TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000000),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '40,000 INR',
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff000000),
                                height: 20 / 14,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: 129),
                      Checkbox(
                        value:
                            isNetworkMemberSelected2, // Change the initial value as needed
                        onChanged: (bool? value) {
                          setState(() {
                            isNetworkMemberSelected2 = value ?? false;
                            isNetworkMemberSelected = false;
                            isNetworkMemberSelected1 = false;
                          });
                          // Handle checkbox state change here
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
