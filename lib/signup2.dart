import 'package:flutter/material.dart';
import 'package:hra/forgot-password.dart';
import 'dart:convert';
import 'package:hra/login.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize =>
      Size.fromHeight(100); // Set the desired height of the custom app bar

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AppBarClipper(), // Custom clipper for curved edges
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFF4D4D), // Set the background color
        ),
        child: AppBar(
          title: Text('Register'),
          centerTitle: true,
          backgroundColor:
              Colors.transparent, // Make the app bar background transparent
          elevation: 0, // Remove the shadow
        ),
      ),
    );
  }
}

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40); // Start at the bottom-left corner
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 40); // Curve
    path.lineTo(size.width, 0); // Line to the top-right corner
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class SignupPage2 extends StatefulWidget {
  final Map<String, dynamic> userData;
  final Map<String, dynamic> docData;

  SignupPage2({required this.userData, required this.docData});

  @override
  _SignupPage2State createState() => _SignupPage2State();
}

class _SignupPage2State extends State<SignupPage2> {
  bool terms = false;
  bool privacy = false;
  String ref_name = "";
  String ref_contact = "";
  String ref_email = "";
  bool loading = false;

  // Get the current date and time
  DateTime currentDateTime = DateTime.now();

  // Response
  List data = [];
  String message = "";
  bool status = false;

  Future<void> p() async {
    print("User data is: ");
    print(widget.userData);
    print("Doc data is: ");
    print(widget.docData);
  }

  Future<void> register() async {
    setState(() {
      loading = true;
    });

    String formattedDateTime = currentDateTime.toUtc().toIso8601String();

    final response = await http.post(
        Uri.parse('https://hra-api-dev.azurewebsites.net/user/api/register-user'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_input': {
            "username": widget.userData['username'],
            "phone": widget.userData['phone'],
            "email": widget.userData['email'],
            "address": widget.userData['address'],
            "city": widget.userData['city'],
            "state": widget.userData['state'],
            "speciality": widget.userData['speciality'],
            "operating_region": widget.userData['region'],
            "user_type": widget.userData['user_type'],
            "rera_expiry_date": widget.userData['establishment_date'],
            "total_experience": widget.userData['experience'],
            "password": "password",
            "tnc": terms,
            "privacy_policy": privacy,
            "created_at ": formattedDateTime,
            "updated_at": formattedDateTime,
            "created_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a",
            "updated_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a",
            "references": [
              {
                "name": ref_name,
                "email": ref_email,
                "phone": ref_contact,
              }
            ]
          }
        }));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        // To Do
        data = jsonData['data'];
        status = jsonData['status'];
        message = jsonData['message'];
      });
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    p();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, bottom: 10),
                        child: Text(
                          'Enter reference details',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF384A59),
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Reference Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintText: 'Reference full name'),
                        onChanged: (value) {
                          setState(() {
                            ref_name = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Reference Contact',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintText: 'Reference phone number'),
                        onChanged: (value) {
                          setState(() {
                            ref_contact = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Reference E-mail',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintText: 'Reference E-mail Id'),
                        onChanged: (value) {
                          setState(() {
                            ref_email = value;
                          });
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: terms,
                          onChanged: (value) {
                            setState(() {
                              terms = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                              'I read carefully and agree to Terms and conditions.'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: privacy,
                          onChanged: (value) {
                            setState(() {
                              privacy = value!;
                            });
                          },
                        ),
                        Expanded(
                          child:
                              Text('I read and agreed to Privacy and Policy.'),
                        ),
                      ],
                    ),
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30), // Adjust the value for the desired corner radius
                            ),
                            side: BorderSide(
                              color:
                                  Color(0xFFFF4D4D), // Specify the border color
                              width: 2.0, // Specify the border width
                            ),
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical:
                                    15), // Change the color to your desired color
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFF4D4D), // Text color
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      loading
                          ? CircularProgressIndicator()
                          : Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  register();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30), // Adjust the value for the desired corner radius
                                  ),
                                  backgroundColor: Color(0xFFFF4D4D),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical:
                                          15), // Change the color to your desired color
                                ),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white, // Text color
                                  ),
                                ),
                              ),
                            ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: message != null
                          ? Text(
                              message,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFF4D4D),
                              ),
                            )
                          : Text(''),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors
                                    .blue, // Change the text color when clicked
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              image: AssetImage('images/ad.jpg'),
                              fit: BoxFit.cover,
                            ),
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
      }),
    );
  }
}
