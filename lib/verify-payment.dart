import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hra/app-config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFF4D4D),
      elevation: 0,
      title: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, right: 20),
            child: Align(
              alignment: Alignment.topCenter,
              // child: Text(

              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 16,
              //     fontFamily: 'Poppins',
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0); // Top-right corner
    path.lineTo(size.width, size.height * 0.5); // Halfway down on the right
    path.lineTo(0, size.height * 0.5); // Halfway down on the left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class PaymentPage extends StatefulWidget {
  // final String imagePath;
  final String user_id;

  PaymentPage({required this.user_id});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool loading = false;
  String? payment_link;
  bool verified = false;

  Future<void> fetchUsers() async {
    setState(() {
      loading = true;
    });
    final response = await http.get(Uri.parse(
        '${AppConfig.apiUrl}/user/api/detail-user?user_id=${widget.user_id}'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<dynamic> apiData = jsonData['data'];

      Map<String, dynamic> data = {};
      data = apiData[0];
      print(apiData[0]);

      setState(() {
        payment_link = data['payment_link'];
        loading = false;
        if (data['is_payment_verified']) {
          verified = true;
        }
      });
    } else {
      print('API request failed with status code:');
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> verifyPayment() async {
    setState(() {
      loading = true;
    });
    final response = await http.get(Uri.parse(
        '${AppConfig.apiUrl}/user/api/verify-payment?user_id=${widget.user_id}'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);

      if (jsonData['status']) {
        setState(() {
          verified = true;
          loading = false;
          payment_link = jsonData['payment_link'];
        });
      }
    } else {
      print('API request failed with status code:');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 100),
              child: Align(
                alignment: Alignment.center,
                // child: Container(
                //   width: 100,
                //   height: 100,
                //   // decoration: BoxDecoration(
                //   //   // image: DecorationImage(
                //   //   //   image: AssetImage('images/profile.png'),
                //   //   //   fit: BoxFit.fill,
                //   //   // ),
                //   //   shape: BoxShape.circle,
                //   //   border: Border.all(
                //   //     color: Color(0xFFF7F7F7),
                //   //     width: 1,
                //   //   ),
                //   // ),
                // ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: DottedBorder(
                  color: Colors.black,
                  strokeWidth: 1,
                  dashPattern: [6, 6],
                  child: Container(
                      height: 349,
                      width: 264,
                      child: Center(
                        child: payment_link != null
                            ? Image.network(
                                payment_link!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'images/payment.jpg',
                                fit: BoxFit.fitHeight,
                              ),
                      ))),
            ),
            SizedBox(height: 49),
            loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : verified
                    ? Center(
                        child: Text("Payment Verified"),
                      )
                    : Container(
                        width: 160, // Set your desired width
                        height: 41, // Set your desired height
                        child: ElevatedButton(
                          onPressed: () {
                            verifyPayment();
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
                            'Confirm',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
