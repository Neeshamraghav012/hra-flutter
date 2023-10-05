import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hra/config/app-config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hra/user-registration/reset-password.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AppBarClipper(),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFF4D4D),
        ),
        child: AppBar(
          title: Text(''),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ForgotPage extends StatefulWidget {
  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  bool loading = false;
  String message = '';
  String email = '';
  bool status = false;
  String otp = '';
  String user_id = '';
  int _counter = 15;
  String otp_message = '';
  bool reSendEmailStatus = false;
  String forgotPasswordId = '';

  TextEditingController textController = TextEditingController();

  Future<void> sendOTP() async {
    setState(() {
      loading = true;
    });

    bool isValidEmail(String email) {
      final emailRegex =
          RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
      return emailRegex.hasMatch(email);
    }

    if (email == '') {
      setState(() {
        message = "Please enter email";
        loading = false;
      });
      return;
    }

    if (!isValidEmail(email)) {
      setState(() {
        message = "Please provide valid email";
        loading = false;
      });

      return;
    }

    final response = await http.get(
      Uri.parse(
          '${AppConfig.apiUrl}/user/api/forgot_password?user_email=${email}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData['data']['user_id']);
      setState(() {
        status = jsonData['status'];
        message = jsonData['message'];
        textController.text = '';
      });

      if (status) {
        setState(() {
          message = "Enter the OTP sent to your email.";
          otp_message = "Enter the OTP sent to your email.";
          forgotPasswordId = jsonData['data']['user_id'];
          loading = false;
        });
      }
    } else {
      setState(() {
        message = "Enter valid email.";
        loading = false;
      });
      print('API request failed with status code: ${response.statusCode}');
    }
    setState(() {
      loading = false;
    });

    if (forgotPasswordId.isEmpty) {
      setState(() {
        message = "Something went wrong. Please try again.";
        loading = false;
      });
    }
  }

  void startTimer() {
    _counter = 15;
    Timer _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          reSendEmailStatus = true;
          timer.cancel();
        }
      });
    });
  }

  Future<void> verifyOTP() async {
    setState(() {
      loading = true;
    });

    final response = await http.get(
      Uri.parse(
          '${AppConfig.apiUrl}/user/api/forgot_password_otp_validation?user_email=${email}&otp=${otp}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        status = jsonData['status'];
        message = jsonData['message'];
      });

      print(jsonData);
      if (status) {
        setState(() {
          user_id = jsonData['data'];
          loading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResetPage(
                    user_id: forgotPasswordId,
                  )),
        );
      }
    } else {
      setState(() {
        message = "OTP is not valid.";
        loading = false;
      });
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
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Color(0xFF384A59),
                        fontSize: 32, // Increase font size
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Enter your registered email ID to reset your password.',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                    !status
                        ? TextField(
                            controller: textController,
                            onChanged: (value) => setState(() {
                              email = value;
                            }),
                            decoration: InputDecoration(
                              labelText: 'Your E-mail',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Your Email',
                            ),
                          )
                        : Column(
                            children: [
                              TextField(
                                controller: textController,
                                onChanged: (value) => setState(() {
                                  otp = value;
                                }),
                                decoration: InputDecoration(
                                  labelText: 'OTP',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.lock),
                                  hintText: 'Enter OTP',
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: InkWell(
                                      onTap: () {
                                        if (reSendEmailStatus == true) {
                                          sendOTP();
                                          setState(() {
                                            reSendEmailStatus = false;
                                          });
                                          startTimer();
                                        }
                                      },
                                      child: reSendEmailStatus == true
                                          ? Text(
                                              "Resend Email?",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            )
                                          : Text(
                                              "You can resend email in $_counter seconds",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Center(
                        child: Text(
                          message ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFFF4D4D),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: loading
                          ? CircularProgressIndicator()
                          : !status
                              ? ElevatedButton(
                                  onPressed: () {
                                    sendOTP();
                                    startTimer();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    primary: Color(0xFFFF4D4D),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 15),
                                  ),
                                  child: Text(
                                    'Send OTP',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    verifyOTP();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    primary: Color(0xFFFF4D4D),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 15),
                                  ),
                                  child: Text(
                                    'Verify OTP',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                    ),
                    SizedBox(height: 300),
                    Align(
                      alignment: Alignment.bottomCenter,
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
