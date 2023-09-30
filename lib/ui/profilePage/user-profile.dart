import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:hra/config/app-config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                'User Profile',
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

class UserProfile extends StatefulWidget {
  final String user_id;

  UserProfile({
    required this.user_id,
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
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
            address: data['address'],
            State: data['state'],
            city: data['city'],
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

      print("profile picture is: ");
      print(userData.profile_url!);
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
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                      image: userData.profile_url != ''
                          ? NetworkImage(userData.profile_url!)
                          : const AssetImage('images/profile.png')
                              as ImageProvider,
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
            DefaultTabController(
              length: 2,
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
                                    // Tab(text: "Documents"),
                                    // Tab(text: "References"),
                                  ]),
                            ),
                          ),
                    Container(
                      height: MediaQuery.of(context).size.height - 350,
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
