import 'package:flutter/material.dart';
import 'package:hra/forgot-password.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hra/signup.dart';
import 'package:hra/admin.dart';

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
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false;
  String email_or_phone = '';
  String password = '';
  bool loading = false;
  bool status = false;
  String message = '';
  String id = '';

  Future<void> fetchPost() async {
    setState(() {
      loading = true;
    });
    final response =
        await http.post(Uri.parse('http://10.0.2.2:8887/user/api/login-user'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "login_input": {"username": email_or_phone, "password": password}
            }));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        status = jsonData['status'];
        message = jsonData['message'];
        id = jsonData['data'];
      });
    } else {
      print('API request failed with status code: ${response.statusCode}');
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
                      'Welcome!',
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
                      padding: const EdgeInsets.all(4.0),
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Email / Phone number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: Icon(Icons.email),
                            hintText: 'Your Email / Phone number'),
                        onChanged: (value) {
                          setState(() {
                            email_or_phone = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: Icon(Icons.password),
                          hintText: 'Your Password',
                        ),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          },
                        ),
                        Text('Remember Me'),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPage()),
                            );
                          },
                          child: Text('Forgot Password?'),
                        ),
                      ],
                    ),
                    loading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              // Perform login logic here
                              fetchPost();
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
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white, // Text color
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
                                color:Color(0xFFFF4D4D),
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
                            "Don't have an account? ",
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
                                    builder: (context) => SignupPage()),
                              );
                            },
                            child: Text(
                              "Signup",
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
