import 'package:flutter/material.dart';
import 'package:hra/user-registration/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hra/config/app-config.dart';

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
          title: Text('Login'),
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

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResetPage(),
    );
  }
}

class ResetPage extends StatefulWidget {
  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  String password = '';
  String user_id = '';
  bool loading = false;
  bool status = false;
  String message = '';
  String id = '';

  Future<void> resetPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
      user_id = prefs.getString("userId")!;
    });

    final response = await http.post(
        Uri.parse('${AppConfig.apiUrl}/user/api/reset_password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "reset_password_input": {"user_id": user_id, "password": password}
        }));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        status = jsonData['status'];
        message = jsonData['message'];
        //id = jsonData['data'];
      });

      if (status) {
        setState(() {
          loading = false;
        });
      }
    } else {
      print('API request failed with status code: ${response.statusCode}');
      setState(() {
        loading = false;
      });
    }
    setState(() {
      loading = false;
    });
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
                    Text(
                      'Reset Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF384A59),
                        fontSize: 28,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              10), // Match the border radius
                          child: Image(
                            image: AssetImage('images/vector.jpg'),
                            fit: BoxFit.cover,
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
                              'Password',
                              style: TextStyle(
                                color: Color(0xFF312E49),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your new password'),
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                      ]),
                    ),
                    loading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              resetPassword();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Color(0xFFFF4D4D),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                            ),
                            child: Text(
                              'Confirm Password',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
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
                    status ? InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color:
                              Colors.blue, // Change the text color when clicked
                        ),
                      ),
                    ) : Container(),
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
