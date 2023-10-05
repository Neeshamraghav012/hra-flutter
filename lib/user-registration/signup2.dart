import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:hra/user-registration/login.dart';
import 'package:http/http.dart' as http;
import 'package:hra/user-registration/signup.dart';
import 'package:hra/user-registration/registered.dart';
import 'package:hra/config/app-config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(150);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFFF4D4D),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: AppBar(
        title: Text('Register'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFFF4D4D),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Personal Info",
                          style: TextStyle(color: Colors.white),
                        ), // Add your label text here
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Container(
                            width: 120,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color(0xFFA1FF89),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Documents",
                          style: TextStyle(color: Colors.white),
                        ), // Add your label text here
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Container(
                            width: 120,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color(0xFFA1FF89),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Refrences",
                          style: TextStyle(color: Colors.white),
                        ), // Add your label text here
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Container(
                            width: 120,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color(0xFFA1FF89),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class SignupPage2 extends StatefulWidget {
  final Map<String, dynamic> userData;
  final Map<String, dynamic> docData;

  SignupPage2({required this.userData, required this.docData});

  @override
  _SignupPage2State createState() => _SignupPage2State();
}

class _SignupPage2State extends State<SignupPage2> {
  bool isValidEmail(String email) {
    // Regular expression for a valid email address
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool terms = false;
  bool privacy = false;
  String ref_name = "";
  String ref_contact = "";
  String ref_email = "";
  bool loading = false;
  String error = "";

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
    if (!privacy && !terms) {
      setState(() {
        error = "Please provide all the details";
      });

      return;
    }

    setState(() {
      loading = true;
    });

    String formattedDateTime = currentDateTime.toUtc().toIso8601String();

    final response =
        await http.post(Uri.parse('${AppConfig.apiUrl}/user/api/register-user'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'user_input': {
                "username": widget.userData['username'],
                "phone": widget.userData['phone'],
                "email": widget.userData['email'],
                "speciality": widget.userData['speciality'],
                "operating_region": widget.userData['region'],
                "user_type": int.parse(widget.userData['user_type']),
                "rera_expiry_date": widget.userData['establishment_date'],
                "total_experience": widget.userData['experience'],
                "password": widget.userData['password'],
                "tnc": terms,
                "privacy_policy": privacy,
                "establishment_name": widget.userData['est'],
                "core_business": widget.userData['core_buisness'],
                "team_size": widget.userData['team_size'],
                "created_at ": formattedDateTime,
                "updated_at": formattedDateTime,
                "created_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a",
                "updated_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a",
                "address": [
                  {
                    "state": widget.userData['state'],
                    "city": widget.userData['city'],
                    "zip": " ",
                    "address": widget.userData['address'],
                    "created_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a",
                    "updated_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a"
                  }
                ],
                "references": [
                  {
                    "name": ref_name,
                    "email": ref_email,
                    "phone": ref_contact,
                    "created_at ": "2023-08-23 16:40:35.998687+05:30",
                    "created_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a",
                    "updated_at": "2023-08-23 16:40:35.998687+05:30",
                    "updated_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a"
                  }
                ],
                "documents": [
                  {
                    "name": "Profile Picture",
                    "document_number": "profile_picture",
                    "document_path": widget.docData['profile_url'],
                    "document_type": "Profile Picture",
                    "created_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a",
                    "updated_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a"
                  },
                  {
                    "name": "Aadhar",
                    "document_number": widget.docData['aadhar_number'],
                    "document_path": widget.docData['aadhar_url'],
                    "document_type": "Aadhar",
                    "created_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a",
                    "updated_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a"
                  },
                  {
                    "name": "PAN",
                    "document_number": widget.docData['pan_number'],
                    "document_path": widget.docData['pan_url'],
                    "document_type": "PAN",
                    "created_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a",
                    "updated_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a"
                  },
                  {
                    "name": "RERA",
                    "document_number": widget.docData['rera_number'],
                    "document_path": widget.docData['rera_url'],
                    "document_type": "RERA",
                    "created_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a",
                    "updated_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a"
                  }
                ]
              }
            }));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      print(jsonData);

      setState(() {
        // To Do
        data = jsonData['data'];
        status = jsonData['status'];
        error = jsonData['message'];
      });

      if (status) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubmitPage(),
            ));
      }
    } else {
      setState(() {
        error = error;
      });
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
                      padding: const EdgeInsets.all(6.0),
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Reference Name',
                              style: TextStyle(
                                color: Color(0xFF312E49),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Reference Full Name'),
                          onChanged: (value) {
                            setState(() {
                              ref_name = value;
                            });
                          },
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Reference Contact',
                              style: TextStyle(
                                color: Color(0xFF312E49),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            } else if (value.length != 10) {
                              return 'Phone number must be 10 digits';
                            }
                            return null; // Return null if the input is valid
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Reference phone number'),
                          onChanged: (value) {
                            setState(() {
                              ref_contact = value;
                            });
                          },
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Reference E-mail',
                              style: TextStyle(
                                color: Color(0xFF312E49),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType
                              .emailAddress, // Set keyboard type to email
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email address';
                            } else if (!isValidEmail(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null; // Return null if the input is valid
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter E-mail Id'),
                          onChanged: (value) {
                            setState(() {
                              ref_email = value;
                            });
                          },
                        ),
                      ]),
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
                          child: RichText(
                            text: TextSpan(
                              text: 'I read carefully and agree to ',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Terms and Conditions',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (await canLaunchUrl(Uri.parse(
                                          'https://onfocussoft.com/hra-privacypolicy/'))) {
                                        await launchUrl(
                                          Uri.parse(
                                              'https://onfocussoft.com/hra-privacypolicy/'),
                                        );
                                      } else {
                                        print(await canLaunchUrl(Uri.parse(
                                            'https://onfocussoft.com/hra-privacypolicy/')));
                                      }
                                    },
                                ),
                                TextSpan(
                                  text: '.',
                                ),
                              ],
                            ),
                          ),
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
                          child: RichText(
                            text: TextSpan(
                              text: 'I read and agreed to ',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Privacy and Policy',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (await canLaunchUrl(Uri.parse(
                                          'https://onfocussoft.com/hra-privacypolicy/'))) {
                                        await launchUrl(
                                          Uri.parse(
                                              'https://onfocussoft.com/hra-privacypolicy/'),
                                        );
                                      } else {
                                        print(await canLaunchUrl(Uri.parse(
                                            'https://onfocussoft.com/hra-privacypolicy/')));
                                      }
                                    },
                                ),
                                TextSpan(
                                  text: '.',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: error != ''
                          ? Text(
                              error,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFF4D4D),
                              ),
                            )
                          : Text(''),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 139, // Set the width for the Cancel button
                          height: 35, // Set the height for the Cancel button
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              side: BorderSide(
                                color: Color(0xFFFF4D4D),
                                width: 2.0,
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: Color(0xFFFF4D4D),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            width:
                                9), // Add some space between Cancel and Submit
                        Container(
                          width: 180, // Set the width for the Submit button
                          height: 35, // Set the height for the Submit button
                          child: loading
                              ? Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: () {
                                    register();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    backgroundColor: Color(0xFFFF4D4D),
                                  ),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: error != ''
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
