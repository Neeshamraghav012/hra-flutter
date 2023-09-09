import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:hra/verify-payment.dart';
import 'package:hra/app-config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
              child: Text(
                'View Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
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

class References {
  final String? name;
  final String? email;
  final String? phone;

  References({this.email, this.name, this.phone});
}

class UserData {
  String? username;
  String? email;
  String? phone;
  String? address;
  String? city;
  String? State;
  String? Speciality;
  int? experience;
  String? rera_exp;
  String? operating_region;
  int? user_type;
  String? org;
  String? core_business;
  String? team_size;
  String? aadhar_number;
  String? pan_number;
  String? rera_number;
  String? aadhar_url;
  String? rera_url;
  String? pan_url;
  String? profile_url;
  bool is_payment_verified;
  bool is_profile_activated;
  String? ref_name;
  String? ref_phone;
  String? ref_email;

  UserData({
    this.email = '',
    this.username = '',
    this.phone = '',
    this.address = '',
    this.city = '',
    this.State = '',
    this.Speciality = '',
    this.experience = 2,
    this.rera_exp = '',
    this.operating_region = '',
    this.user_type = 1,
    this.org = '',
    this.core_business = '',
    this.team_size = '',
    this.aadhar_number = '',
    this.pan_number = '',
    this.rera_number = '',
    this.aadhar_url = '',
    this.rera_url = '',
    this.pan_url = '',
    this.profile_url = '',
    this.is_payment_verified = false,
    this.is_profile_activated = false,
    this.ref_name = '',
    this.ref_phone = '',
    this.ref_email = '',
  });
}

class Frame3875 extends StatefulWidget {
  final String user_id;

  Frame3875({
    required this.user_id,
  });

  @override
  State<Frame3875> createState() => _Frame3875State();
}

class _Frame3875State extends State<Frame3875>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  UserData userData = UserData();

  Map<dynamic, dynamic> user_type_map = {
    1: "Individual",
    2: "Company",
    3: "Partnership",
    4: "Proprietorship"
  };

  Map<dynamic, dynamic> speciality_map = {};
  Map<dynamic, dynamic> region_map = {};
  bool loading = false;
  bool verify_loading = false;
  bool payment_loading = false;

  Future<void> fetchUsers() async {
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
      // print(apiData[0]);

      await initializeDateFormatting('en', null);

      final inputString = data['rera_exp'];

      final inputFormat = DateFormat('E, d MMM yyyy HH:mm:ss zzz', 'en');
      final outputFormat = DateFormat('E, d MMM yyyy');

      final inputDate = inputFormat.parse(inputString);
      final formattedDate = outputFormat.format(inputDate);
      // print(formattedDate);

      setState(() {
        userData = UserData(
            username: data['username'],
            email: data['email'],
            phone: data['phone'].toString(),
            experience: data['experience'],
            Speciality: data['speciality'],
            rera_exp: formattedDate,
            operating_region: data['operating_region'],
            user_type: data['user_type'],
            core_business: data['core_business'],
            team_size: data['team_size'],
            org: data['org'],
            is_payment_verified: data['is_payment_verified'],
            is_profile_activated: data['is_profile_activated'],
            aadhar_number: data['aadhar_number'],
            aadhar_url: data['aadhar_url'],
            pan_number: data['pan_number'],
            pan_url: data['pan_url'],
            rera_number: data['rera_number'],
            rera_url: data['rera_url'],
            profile_url: data['profile_url'],
            ref_name: data['ref_name'],
            ref_email: data['ref_email'],
            ref_phone: data['ref_contact']);
        loading = false;
      });
      print("rera number is: ");
      print(userData.rera_number);
    } else {
      print('API request failed with status code:');
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> activateUser() async {
    setState(() {
      loading = true;
    });
    final response = await http.get(Uri.parse(
        '${AppConfig.apiUrl}/user/api/activate_user_profile?user_id=${widget.user_id}'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);

      setState(() {
        loading = false;
        if (jsonData['status']) {
          userData.is_profile_activated = true;
        }
      });
    } else {
      print('API request failed with status code:');
      setState(() {
        loading = false;
      });
    }
  }

  // Function to get the app's documents directory
  Future<String> getAppDocumentsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> verifyPayment() async {
    final response = await http.get(Uri.parse(
        '${AppConfig.apiUrl}/user/api/verify_payment?user_id=${widget.user_id}'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);

      if (jsonData['status']) {
        userData.is_payment_verified = true;
      }
    } else {
      print('API request failed with status code:');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Verify Dialog
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Are you sure you want to verify?'),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 110,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: Text('Cancel'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 110,
                      height: 30, // Add some spacing between the buttons
                      child: verify_loading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                if (userData.is_profile_activated) {
                                  verifyPayment();
                                } else {
                                  activateUser();
                                }
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red, // Set the background color
                              ),
                              child: Text('Confirm'),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
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
              padding: EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/profile.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFFF7F7F7),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(bottom: 15, top: 15),
                child: Container(
                  width: 150,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Color(0xFFA1FF89),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (userData.is_profile_activated) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentPage(
                              user_id: widget.user_id,
                            ),
                          ),
                        );
                      } else {
                        _showConfirmationDialog(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color(0xFFA1FF89), // Use primary for background color
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: Size(120, 40),
                      padding: EdgeInsets.all(0), // Set padding here
                    ),
                    child: Center(
                      child: userData.is_profile_activated &&
                              userData.is_payment_verified
                          ? Text(
                              "Verified Member",
                              style: TextStyle(color: Colors.black),
                            )
                          : userData.is_profile_activated
                              ? Text(
                                  "Verify Payment",
                                  style: TextStyle(color: Colors.black),
                                )
                              : Text(
                                  'Verify',
                                  style: TextStyle(color: Colors.black),
                                ),
                    ),
                  ),
                ),
              ),
            ),
            DefaultTabController(
              length: 4,
              child: Expanded(
                child: Column(
                  children: <Widget>[
                    loading
                        ? Center(
                              child: CircularProgressIndicator(),
                            )
  
                        : Flexible(
                            child: Container(
                              child: TabBar(
                                  labelColor: Colors.black,
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  labelStyle: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                  ), // Adjust label font size
                                  indicatorSize: TabBarIndicatorSize.label,
                                  tabs: [
                                    Tab(text: "Personal Info"),
                                    Tab(text: "Organisation"),
                                    Tab(text: "Documents"),
                                    Tab(text: "References"),
                                  ]),
                            ),
                          ),
                    Container(
                      height: MediaQuery.of(context).size.height - 300,
                      child: loading
                          ? Container()
                          : TabBarView(children: [
                              SingleChildScrollView(
                                // Personal Info
                                child: Container(
                                  child: Column(
                                    children: [
                                      Info(
                                          label: "Full name",
                                          val: userData.username!),
                                      Info(
                                          label: "Email", val: userData.email!),
                                      Info(
                                        label: "Mobile number",
                                        val: userData.phone!,
                                      ),
                                      userData.address != ''
                                          ? Info(
                                              label: "Address",
                                              val: userData.address!)
                                          : Container(),
                                      userData.city != ''
                                          ? Infocolumn(
                                              label1: "City",
                                              val1: userData.city!,
                                              label2: "State",
                                              val2: userData.State!,
                                            )
                                          : Container(),
                                      userData.Speciality != ''
                                          ? Infocolumn(
                                              label1: "Speciality",
                                              val1: userData.Speciality!,
                                              label2: "Total experience",
                                              val2: userData.experience!
                                                  .toString())
                                          : Container(),
                                      userData.rera_exp != ''
                                          ? Infocolumn(
                                              label1: "RERA Expiry Date",
                                              val1: userData.rera_exp!,
                                              label2: "Operating region",
                                              val2: userData.operating_region ==
                                                      ''
                                                  ? "North"
                                                  : userData.operating_region)
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),

                              // Organization Tab
                              Container(
                                child: Column(children: [
                                  userData.user_type != null
                                      ? Info(
                                          label: "User type",
                                          val:
                                              user_type_map[userData.user_type!]
                                                  .toString(),
                                        )
                                      : Container(),
                                  userData.user_type != 1 &&
                                          userData.org != null
                                      ? Info(
                                          label: "Establishment Name",
                                          val: userData.org!,
                                        )
                                      : Container(),
                                  userData.user_type != 1 &&
                                          userData.team_size != null
                                      ? Info(
                                          label: "Team Size",
                                          val: userData.team_size!,
                                        )
                                      : Container(),
                                  userData.user_type != 1 &&
                                          userData.core_business != null
                                      ? Info(
                                          label: "Core Business",
                                          val: userData.core_business!,
                                        )
                                      : Container(),
                                ]),
                              ),

                              // Document tab
                              Container(
                                child: Column(children: [
                                  userData.pan_number != ''
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              left: 30, top: 10),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'PAN Card',
                                              style: TextStyle(
                                                color: Color(0xFF212121),
                                                fontSize: 12,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                height: 1.50,
                                                letterSpacing: 0.25,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  userData.pan_number != ''
                                      ? Info(
                                          label: "PAN Number",
                                          val: userData.pan_number!)
                                      : Container(),
                                  userData.aadhar_number != ''
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              left: 30, top: 10),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Aadhar Card',
                                              style: TextStyle(
                                                color: Color(0xFF212121),
                                                fontSize: 12,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                height: 1.50,
                                                letterSpacing: 0.25,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  userData.aadhar_number != ''
                                      ? Info(
                                          label: "Aadhar Number",
                                          val: userData.aadhar_number!)
                                      : Container(),
                                  userData.rera_number != ''
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              left: 30, top: 10),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'RERA',
                                              style: TextStyle(
                                                color: Color(0xFF212121),
                                                fontSize: 12,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                height: 1.50,
                                                letterSpacing: 0.25,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  userData.rera_number != ''
                                      ? Info(
                                          label: "RERA Number",
                                          val: userData.rera_number!)
                                      : Container(),
                                  userData.aadhar_url != ''
                                      ? ElevatedButton.icon(
                                          onPressed: () async {
                                            String? url = userData.pan_url;
                                            if (await canLaunchUrl(
                                                Uri.parse(url!))) {
                                              await launchUrl(Uri.parse(url!));
                                            } else {
                                              print('Could not launch $url');
                                            }
                                          },
                                          icon: Icon(Icons.file_download),
                                          label: Text("Verify Documents"),
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF3C3C3C),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                          ),
                                        )
                                      : Container(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 40),
                                            child: Center(
                                                child: Text(
                                                    "Documents are not provided")),
                                          ),
                                        ),
                                ]),
                              ),

                              // Reference tab
                              Container(
                                child: Column(children: [
                                  userData.ref_name != ''
                                      ? Info(
                                          label: "Reference name",
                                          val: "Leslie Alexander")
                                      : Container(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 40),
                                            child: Center(
                                                child: Text(
                                                    "References are not provided.")),
                                          ),
                                        ),
                                  userData.ref_phone != ''
                                      ? Info(
                                          label: "Reference contact number",
                                          val: "(316) 555-0116")
                                      : Container(),
                                  userData.ref_email != ''
                                      ? Info(
                                          label: "Reference Email",
                                          val: "abc@domain.com")
                                      : Container(),
                                ]),
                              ),
                            ]),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Infocolumn extends StatelessWidget {
  final String label1;
  final dynamic val1;

  final String label2;
  final dynamic val2;

  const Infocolumn({
    Key? key,
    required this.label1,
    required this.val1,
    required this.label2,
    required this.val2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 23, top: 10),
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 5, top: 5),
                      child: Text(
                        label1,
                        style: TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 10,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 1.60,
                          letterSpacing: 0.25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        val1,
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 1.29,
                          letterSpacing: 0.25,
                        ),
                      ),
                    ),
                  ]),
              width: 170,
              height: 50,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFFDBE2EA)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 23, top: 10),
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 5, top: 5),
                      child: Text(
                        label2,
                        style: TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 10,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 1.60,
                          letterSpacing: 0.25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        val2,
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 1.29,
                          letterSpacing: 0.25,
                        ),
                      ),
                    ),
                  ]),
              width: 170,
              height: 50,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFFDBE2EA)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class Info extends StatelessWidget {
  final String label;
  final dynamic val;

  const Info({
    Key? key,
    required this.label,
    required this.val,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 5),
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(left: 15, bottom: 5, top: 5),
            child: Text(
              label,
              style: TextStyle(
                color: Color(0xFF757575),
                fontSize: 10,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.60,
                letterSpacing: 0.25,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              val,
              style: TextStyle(
                color: Color(0xFF212121),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.29,
                letterSpacing: 0.25,
              ),
            ),
          ),
        ]),
        width: 342,
        height: 50,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.50, color: Color(0xFFDBE2EA)),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
