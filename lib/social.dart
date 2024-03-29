import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hra/payments/membership.dart';
import 'package:hra/config/app-config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hra/ui/newsFeedPage/NewsFeed.dart';
import 'package:hra/ui/home.dart';

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
          title: Text('HRA'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          // automaticallyImplyLeading: false,
          automaticallyImplyLeading: false, // Disable the default back button
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Navigate back if no custom action is provided
              }),
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

class SocialPage extends StatefulWidget {
  final String user_id;

  SocialPage({required this.user_id});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  bool loading = false;
  bool is_profile_activated = false;
  bool is_payment_verified = false;
  bool is_email_activated = false;
  String message = "";

  Future<String> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userId") ?? "";

    await prefs.remove('userId');

    return id;
  }

  Future<void> fetchUserDetails() async {
    setState(() {
      loading = true;
    });
    final response = await http.get(Uri.parse(
        '${AppConfig.apiUrl}/user/api/user-detail?user_id=${widget.user_id}'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<dynamic> apiData = jsonData['data'];

      Map<String, dynamic> data = {};
      data = apiData[0];
      print(apiData[0]);

      if (mounted) {
        setState(() {
          loading = false;
          is_profile_activated = data['is_profile_activated'];
          is_payment_verified = data['is_payment_verified'];
          is_email_activated = data['is_email_activated'];
        });
      }

      if (!is_email_activated) {
        message = "We have sent you an email\n please verify it.";
      } else if (is_email_activated && is_profile_activated) {
        message =
            "Your profile has been\n verified by the admin.\n You can pay the membership fees now.";
      } else if (is_email_activated) {
        message =
            "You have successfully applied\n for the member verification.\n Please wait for the admin's approval.";
      }

      if (is_payment_verified && is_profile_activated && is_email_activated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(index: 1,),
          ),
        );
      }

      print(is_payment_verified);
      print(is_profile_activated);
      print(is_email_activated);
    } else {
      print('API request failed with status code:');

      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
    // removeUser();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // <-- SEE HERE
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/registered.jpg',
                height: 200, // Adjust the height as needed
              ),
              SizedBox(height: 20),
              loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      message,
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                        //height: 64 / 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
              is_profile_activated && is_email_activated
                  ? Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MembershipPage()),
                          );
                        },
                        child: Text(
                          "Make Payment",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors
                                .blue, // Change the text color when clicked
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
