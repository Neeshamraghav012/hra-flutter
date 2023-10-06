import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';
import 'package:hra/config/app-config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Edit profile',
        style: TextStyle(
          color: Color(0xFF5B5B5B),
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          height: 0,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  final String user_id;
  const EditProfile({Key? key, required this.user_id}) : super(key: key);
  @override
  State<EditProfile> createState() => _EditProfileState();
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

class _EditProfileState extends State<EditProfile>
    with TickerProviderStateMixin {
  late TabController _tabController;

  bool loading = false;

  UserData userData = UserData();

  Map<dynamic, dynamic> user_type_map = {
    1: "Individual",
    2: "Company",
    3: "Partnership",
    4: "Proprietorship"
  };

  Map<dynamic, dynamic> speciality_map = {};
  Map<dynamic, dynamic> region_map = {};

  // Dropdown lists
  List speciality_list = [];
  List region_list = [];
  // List selected_speciality = [];
  // List selected_business = [];
  List core_business_list = ["Primary", "Secondary", "Lease"];
  String? region;
  String? selected_speciality;
  String? selected_region;

  Map<dynamic, dynamic> user_map = {
    "Individual": "1",
    "Company": "2",
    "Partnership": "3",
    "Proprietorship": "4"
  };

  TextEditingController dateinput = TextEditingController();
  List<String> specialityNames = [''];
  List<String> regionNames = ['North'];

  Future<void> fetchValues() async {
    final response = await http.get(
        Uri.parse('${AppConfig.apiUrl}/admin/api/get-all-dropdown-values'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      speciality_list = jsonData['data']['speciality_list'];
      region_list = jsonData['data']['operating_list'];

      List<String> names = speciality_list
          .where((item) => item['name'] != null)
          .map<String>((item) => item['name'])
          .toList();

      List<String> regions = region_list
          .where((item) => item['name'] != null)
          .map<String>((item) => item['name'])
          .toList();

      speciality_map = Map.fromIterable(
        speciality_list.where(
            (element) => element['id'] != null && element['name'] != null),
        key: (element) => element['name']!,
        value: (element) => element['id']!,
      );

      region_map = Map.fromIterable(
        region_list.where(
            (element) => element['id'] != null && element['name'] != null),
        key: (element) => element['name']!,
        value: (element) => element['id']!,
      );

      setState(() {
        specialityNames = names;
        regionNames = regions;
        speciality_map = speciality_map;
        region_map = region_map;
      });

      print(regionNames);
      print(specialityNames);
    } else {}
  }

  Future<void> saveUser() async {
    setState(() {
      loading = true;
    });
    final response = await http.post(
      Uri.parse('${AppConfig.apiUrl}/user/api/save-user-profile'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "user_input": {
          "id": widget.user_id,
          "username": userData.username,
          "phone": userData.phone,
          "email": userData.email,
          "speciality": speciality_map[selected_speciality],
          "operating_region": region_map[selected_region],
          "user_type": userData.user_type,
          "rera_expiry_date": userData.rera_exp,
          "total_experience": userData.experience,
          "establishment_name": userData.org,
          "core_business": userData.core_business,
          "team_size": userData.team_size,
          "created_at ": userData.rera_exp,
          "updated_at": userData.rera_exp,
          "created_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a",
          "updated_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a",
          "references": [
            {
              "user_id": widget.user_id,
              "name": userData.ref_name,
              "email": userData.ref_email,
              "phone": userData.ref_phone
            }
          ],
          "documents": [
            {
              "user_id": widget.user_id,
              "name": "Aadhar",
              "document_number": userData.aadhar_number,
              "document_path": userData.aadhar_url,
              "document_type": "Aadhar",
              "created_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a",
              "updated_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a"
            },
            {
              "user_id": widget.user_id,
              "name": "PAN",
              "document_number": userData.pan_number,
              "document_path": userData.pan_url,
              "document_type": "PAN",
              "created_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a",
              "updated_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a"
            },
            {
              "user_id": widget.user_id,
              "name": "RERA",
              "document_number": userData.rera_number,
              "document_path": userData.rera_url,
              "document_type": "RERA",
              "created_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a",
              "updated_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a"
            }
          ],
          "address": [
            {
              "user_id": widget.user_id,
              "state": userData.State,
              "city": userData.city,
              "zip": " ",
              "address": userData.address,
              "created_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a",
              "updated_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a"
            }
          ],
        },
      }),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);

      if (jsonData['status']) {
        var snackdemo = SnackBar(
          content: Text("Profile Updated Successfully"),
          backgroundColor: Colors.green,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);

        setState(() {
          loading = false;
        });
        Navigator.pop(context);
      } else {
        var snackdemo = SnackBar(
          content: Text("Something went wrong"),
          backgroundColor: Colors.green,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);

        setState(() {
          loading = false;
        });
      }

      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

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

      setState(() {
        dateinput.text = userData.rera_exp!;
        selected_region = "North";
        selected_speciality = "Residential";
        // selected_region = userData.operating_region!.toUpperCase();
        // selected_speciality = userData.Speciality!.toUpperCase();
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchValues();
    fetchUsers();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Column(
          children: [
            /*Padding(
              padding: EdgeInsets.only(
                  top: 16.0,
                  left: 16,
                  right: 16), // Adjust the top padding as needed
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 68,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage(
                              'images/ad1.jpg'), // Replace with your image path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),*/
            Container(
              child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  labelStyle: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ), // Adjust label font size
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Color(0xFF707070),
                  tabs: [
                    Tab(text: "Personal Info"),
                    Tab(text: "Organization"),
                    Tab(text: "Documents"),
                    Tab(text: "References"),
                  ]),
            ),
            Expanded(
              child: loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        // Rectangle Box 1
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(children: [
                                  Container(
                                    height: 50,
                                    //width: 170,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter full name';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Full Name',
                                        // hintText: 'Enter your city',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 8),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          userData.username = value;
                                        });
                                      },
                                      initialValue: userData.username,
                                    ),
                                  ),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(children: [
                                  Container(
                                    height: 50,
                                    //width: 170,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter email';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Email',
                                        // hintText: 'Enter your city',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 8),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          userData.email = value;
                                        });
                                      },
                                      readOnly: true,
                                      initialValue: userData.email,
                                    ),
                                  ),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(children: [
                                  Container(
                                    height: 50,
                                    //width: 170,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter number';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Mobile Number',
                                        // hintText: 'Enter your city',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 8),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          userData.phone = value;
                                        });
                                      },
                                      readOnly: true,
                                      initialValue: userData.phone,
                                    ),
                                  ),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(children: [
                                  Container(
                                    height: 50,
                                    //width: 170,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter address';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Address',
                                        // hintText: 'Enter your city',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 8),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          userData.address = value;
                                        });
                                      },
                                      initialValue: userData.address,
                                    ),
                                  ),
                                ]),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, left: 16, bottom: 16),
                                      child: Column(children: [
                                        Container(
                                          height: 50,
                                          // width: 170,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: Colors.white,
                                          ),
                                          child: TextFormField(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your city';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              labelText: 'City',
                                              // hintText: 'Enter your city',
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 8),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                userData.city = value;
                                              });
                                            },
                                            initialValue: userData.city,
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  SizedBox(width: 9),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, right: 16, bottom: 16),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            // width: 170,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              color: Colors.white,
                                            ),
                                            child:
                                                DropdownButtonFormField<String>(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 8),
                                                border: InputBorder.none,
                                                // hintText: 'Select',
                                                labelText: 'State',
                                              ),
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              value: userData.State,
                                              isExpanded: true,
                                              items: <String>[
                                                "Andhra Pradesh",
                                                "Arunachal Pradesh",
                                                "Assam",
                                                "Bihar",
                                                "Chhattisgarh",
                                                "Goa",
                                                "Gujarat",
                                                "Haryana",
                                                "Himachal Pradesh",
                                                "Jharkhand",
                                                "Karnataka",
                                                "Kerala",
                                                "Madhya Pradesh",
                                                "Maharashtra",
                                                "Manipur",
                                                "Meghalaya",
                                                "Mizoram",
                                                "Nagaland",
                                                "Odisha",
                                                "Punjab",
                                                "Rajasthan",
                                                "Sikkim",
                                                "Tamil Nadu",
                                                "Telangana",
                                                "Tripura",
                                                "Uttar Pradesh",
                                                "Uttarakhand",
                                                "West Bengal",
                                                "Andaman and Nicobar Islands",
                                                "Chandigarh",
                                                "Dadra and Nagar Haveli and Daman and Diu",
                                                "Lakshadweep",
                                                "Delhi",
                                                "Puducherry"
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  userData.State = newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, left: 16, bottom: 16),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            // width: 170,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              color: Colors.white,
                                            ),
                                            child:
                                                DropdownButtonFormField<String>(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 8),
                                                border: InputBorder.none,
                                                // hintText: 'Select',
                                                labelText: 'Speciality',
                                              ),
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              value: selected_speciality,
                                              isExpanded: true,
                                              items: <String>[
                                                "Residential",
                                                "Investment Deals",
                                                "Commercial",
                                                "Pre-Leased",
                                                "Land"
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  selected_speciality =
                                                      newValue!;

                                                  userData.Speciality =
                                                      speciality_map[newValue];
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 9),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, right: 16, bottom: 16),
                                      child: Column(children: [
                                        Container(
                                          height: 50,
                                          // width: 170,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: Colors.white,
                                          ),
                                          child: TextFormField(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter experience';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              labelText: 'Total Experience',
                                              // hintText: 'Enter your city',
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 8),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                userData.experience =
                                                    value as int;
                                              });
                                            },
                                            initialValue:
                                                userData.experience.toString(),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, left: 16, bottom: 16),
                                      child: Column(children: [
                                        Container(
                                          height: 50,
                                          // width: 170,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: Colors.white,
                                          ),
                                          child: TextFormField(
                                            controller: dateinput,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                                vertical: 8,
                                              ),
                                              border: InputBorder.none,
                                              // hintText: 'Select Date',
                                              labelText: 'RERA Expiry Date',
                                              // suffixIcon: Icon(Icons
                                              //     .calendar_today), // Icon on the right side
                                            ),
                                            readOnly: true,
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(2101),
                                              );

                                              if (pickedDate != null) {
                                                String formattedDate =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(pickedDate);

                                                setState(() {
                                                  dateinput.text =
                                                      formattedDate;
                                                  userData.rera_exp =
                                                      formattedDate;
                                                });
                                              } else {}
                                            },
                                            // initialValue: userData.rera_exp,
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  SizedBox(width: 9),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, right: 16, bottom: 16),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            // width: 170,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              color: Colors.white,
                                            ),
                                            child:
                                                DropdownButtonFormField<String>(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 8),
                                                border: InputBorder.none,
                                                // hintText: 'Select',
                                                labelText: 'Operating Region',
                                              ),
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              value: selected_region,
                                              isExpanded: true,
                                              items: <String>[
                                                "North",
                                                "South",
                                                "East",
                                                "West"
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  selected_region = newValue!;
                                                  userData.operating_region =
                                                      region_map[newValue];
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              SizedBox(
                                width: 166, // Set your desired width
                                height: 43, // Set your desired height
                                child: ElevatedButton(
                                  onPressed: () {
                                    saveUser();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    backgroundColor: Color(0xFFFF4D4D),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 10,
                                    ),
                                  ),
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Rectangle Box 2
                        SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              /*Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(children: [
                            Container(
                              height: 50,
                              //width: 170,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter org type';
                                  }
                                  return null; // Return null if the input is valid
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Org type',
                                  // hintText: 'Enter your city',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 8),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    userData.core_business = value;
                                  });
                                },
                                initialValue: userData.or,
                              ),
                            ),
                          ]),
                        ),*/
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(children: [
                                  Container(
                                    height: 50,
                                    //width: 170,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter the name of establishment';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Name of Establishment',
                                        // hintText: 'Enter your city',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 8),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          userData.org = value;
                                        });
                                      },
                                      initialValue: userData.org,
                                    ),
                                  ),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(children: [
                                  Container(
                                    height: 50,
                                    //width: 170,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter size';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Team size',
                                        // hintText: 'Enter your city',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 8),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          userData.team_size = value;
                                        });
                                      },
                                      initialValue: userData.team_size,
                                    ),
                                  ),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(children: [
                                  Container(
                                    height: 50,
                                    //width: 170,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter business type';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Core Business type',
                                        // hintText: 'Enter your city',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 8),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          userData.core_business = value;
                                        });
                                      },
                                      initialValue: userData.core_business,
                                    ),
                                  ),
                                ]),
                              ),
                              SizedBox(height: 30),
                              SizedBox(
                                width: 166, // Set your desired width
                                height: 43, // Set your desired height
                                child: ElevatedButton(
                                  onPressed: () {
                                    saveUser();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    backgroundColor: Color(0xFFFF4D4D),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 10,
                                    ),
                                  ),
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ])),
                        // Rectangle Box 3
                        SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.white,
                                      ),
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter Aadhar Card';
                                          }
                                          return null; // Return null if the input is valid
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText:
                                              'Aadhar card', // Remove the labelText from here
                                          hintText: 'Enter your Aadhar Card',
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 8,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            userData.aadhar_number = value;
                                          });
                                        },
                                        initialValue: userData.aadhar_number,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            8), // Add some spacing between the container and text/icons
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween, // Align the text and icons
                                      children: [
                                        Text(
                                          'Aadhar Card',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons
                                                .remove_red_eye), // Replace with your icon widget
                                            SizedBox(
                                                width:
                                                    8), // Add some spacing between icons
                                            Icon(Icons
                                                .cloud_download), // Replace with your icon widget
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(children: [
                                  Container(
                                    height: 50,
                                    //width: 170,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter Pan card';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Pan Card',
                                        // hintText: 'Enter your city',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 8),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          userData.pan_number = value;
                                        });
                                      },
                                      initialValue: userData.pan_number,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          8), // Add some spacing between the container and text/icons
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween, // Align the text and icons
                                    children: [
                                      Text(
                                        'Pan Card',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons
                                              .remove_red_eye), // Replace with your icon widget
                                          SizedBox(
                                              width:
                                                  8), // Add some spacing between icons
                                          Icon(Icons
                                              .cloud_download), // Replace with your icon widget
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(children: [
                                  Container(
                                    height: 50,
                                    //width: 170,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter Rera card';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'RERA Card',
                                        // hintText: 'Enter your city',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 8),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          userData.rera_number = value;
                                        });
                                      },
                                      initialValue: userData.rera_number,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          8), // Add some spacing between the container and text/icons
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween, // Align the text and icons
                                    children: [
                                      Text(
                                        'RERA Card',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons
                                              .remove_red_eye), // Replace with your icon widget
                                          SizedBox(
                                              width:
                                                  8), // Add some spacing between icons
                                          Icon(Icons
                                              .cloud_download), // Replace with your icon widget
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                              SizedBox(height: 50),
                              SizedBox(
                                width: 166, // Set your desired width
                                height: 43, // Set your desired height
                                child: ElevatedButton(
                                  onPressed: () {
                                    saveUser();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    backgroundColor: Color(0xFFFF4D4D),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 10,
                                    ),
                                  ),
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ])),
                        // Rectangle Box 4
                        SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(children: [
                                  Container(
                                    height: 50,
                                    //width: 170,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter reference name';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Reference name',
                                        // hintText: 'Enter your city',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 8),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          userData.ref_name = value;
                                        });
                                      },
                                      initialValue: userData.ref_name,
                                    ),
                                  ),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(children: [
                                  Container(
                                    height: 50,
                                    //width: 170,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter the reference contact';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Reference Contact number',
                                        // hintText: 'Enter your city',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 8),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          userData.ref_phone = value;
                                        });
                                      },
                                      initialValue: userData.ref_phone,
                                    ),
                                  ),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(children: [
                                  Container(
                                    height: 50,
                                    //width: 170,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter the reference contact';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Reference Email',
                                        // hintText: 'Enter your city',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 8),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          userData.ref_email = value;
                                        });
                                      },
                                      initialValue: userData.ref_email,
                                    ),
                                  ),
                                ]),
                              ),
                              SizedBox(height: 50),
                              SizedBox(
                                width: 166, // Set your desired width
                                height: 43, // Set your desired height
                                child: ElevatedButton(
                                  onPressed: () {
                                    saveUser();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    backgroundColor: Color(0xFFFF4D4D),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 10,
                                    ),
                                  ),
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ])),
                      ],
                    ),
            ),
            /* Padding(
              padding: EdgeInsets.only(
                  top: 16.0,
                  left: 16,
                  right: 16), // Adjust the top padding as needed
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 68,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage(
                              'images/ad1.jpg'), // Replace with your image path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
