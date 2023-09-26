import 'package:flutter/material.dart';
import 'package:hra/payments/membership-1.dart';
import 'package:hra/ui/newsFeedPage/widgets/feedCard.dart';
import 'dart:math' as math;

class MembershipPage extends StatefulWidget {
  @override
  _MembershipState createState() => _MembershipState();
}

class _MembershipState extends State<MembershipPage> {
  bool isNetworkMemberSelected = false;
  bool isNetworkMemberSelected1 = false; // Track checkbox state
  bool isNetworkMemberSelected2 = false;
  bool canProceed = false;

  bool isAnyCheckboxSelected() {
    return isNetworkMemberSelected ||
        isNetworkMemberSelected1 ||
        isNetworkMemberSelected2;
  }

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

                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ]), // Adjust padding as needed
                  child: Row(
                    children: <Widget>[
                      // SizedBox(
                      //   width: 10,
                      // ),
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
                      Spacer(),
                      Checkbox(
                        value: isNetworkMemberSelected,
                        onChanged: (newValue) {
                          setState(() {
                            isNetworkMemberSelected = !isNetworkMemberSelected;
                            isNetworkMemberSelected1 = false;
                            isNetworkMemberSelected2 = false;
                          });
                          // Handle checkbox state change here
                        },
                        activeColor:
                            Colors.blue, // Change the color to red when checked
                        checkColor:
                            Colors.white, // Change the color of the checkmark
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22),
                Container(
                  width: 328,
                  height: 61,

                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ]), // Adjust padding as needed
                  child: Row(
                    children: <Widget>[
                      // SizedBox(
                      //   width: 10,
                      // ),
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
                      Spacer(),
                      Checkbox(
                        value: isNetworkMemberSelected1,
                        onChanged: (newValue) {
                          setState(() {
                            isNetworkMemberSelected = false;
                            isNetworkMemberSelected1 =
                                !isNetworkMemberSelected1;
                            isNetworkMemberSelected2 = false;
                          });
                          // Handle checkbox state change here
                        },
                        activeColor:
                            Colors.blue, // Change the color to red when checked
                        checkColor:
                            Colors.white, // Change the color of the checkmark
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22),
                Container(
                  width: 328,
                  height: 61,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ]),
                  child: Row(
                    children: <Widget>[
                      // SizedBox(
                      //   width: 10,
                      // ),
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
                      Spacer(),
                      Checkbox(
                        value: isNetworkMemberSelected2,
                        onChanged: (newValue) {
                          setState(() {
                            isNetworkMemberSelected = false;
                            isNetworkMemberSelected1 = false;
                            isNetworkMemberSelected2 =
                                !isNetworkMemberSelected2;
                          });
                          // Handle checkbox state change here
                        },
                        activeColor:
                            Colors.blue, // Change the color to red when checked
                        checkColor:
                            Colors.white, // Change the color of the checkmark
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: isAnyCheckboxSelected()
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MembershipPage1()),
                            );
                          }
                        : null,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
