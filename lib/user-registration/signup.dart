import 'package:flutter/material.dart';
import 'package:hra/user-registration/forgot-password.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hra/user-registration/signup1.dart';
import 'package:hra/user-registration/login.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/services.dart';
import 'package:hra/config/app-config.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                              color: Colors.white,
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
                              color: Colors.white,
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

class SignupApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isValidEmail(String email) {
    // Regular expression for a valid email address
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPhoneNumber(String phoneNumber) {
    // Regular expression for a valid phone number
    final phoneRegex = RegExp(r'^\d{10}$');
    return phoneRegex.hasMatch(phoneNumber);
  }

  // input values
  String username = "";
  String email = "";
  String address = "";
  String phone = "";
  String city = "";
  String experience = "";
  String est = "";
  String? state;
  String? speciality;
  String? region;
  String? user_type;
  String user_type_id = "2";
  String? team_size;
  String? core_business;
  String establishment_date = "";
  String password = "";
  String error = "";
  String region_id = "138f3a4d-83ff-4ddc-93f2-ef15e5d4f3d4";
  bool show_password = false;

  // Dropdown lists
  List speciality_list = [];
  List region_list = [];
  List selected_speciality = [];
  List selected_business = [];
  List core_business_list = ["Primary", "Secondary", "Lease"];

  Future<void> saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("username", username);
    await prefs.setString("email", email);
    await prefs.setString("password", password);
    await prefs.setString("phone", phone);
    await prefs.setString("city", city);
    await prefs.setString("experience", experience);
    await prefs.setString("est", est);
    await prefs.setString("state", state!);
    await prefs.setString("address", address);
    await prefs.setString("speciality", speciality!);
    await prefs.setString("region", region!);
    await prefs.setString("user_type", user_type!);
    await prefs.setString("team_size", team_size!);
    await prefs.setString("core_business", core_business!);
    await prefs.setString("establishment_date", establishment_date);
  }

  Future<void> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("username")!;
    email = prefs.getString("email")!;
    password = prefs.getString("password")!;
    phone = prefs.getString("phone")!;
    city = prefs.getString("city")!;
    experience = prefs.getString("experience")!;
    est = prefs.getString("est")!;
    state = prefs.getString("state");
    address = prefs.getString("address")!;
    speciality = prefs.getString("speciality");
    region = prefs.getString("region");
    user_type = prefs.getString("user_type");
    team_size = prefs.getString("team_size");
    core_business = prefs.getString("core_business");
    establishment_date = prefs.getString("establishment_date")!;
  }

  Map<dynamic, dynamic> speciality_map = {};
  Map<dynamic, dynamic> region_map = {};
  Map<dynamic, dynamic> user_map = {
    "Individual": "1",
    "Company": "2",
    "Partnership": "3",
    "Proprietorship": "4"
  };

  TextEditingController dateinput = TextEditingController();
  List<String> specialityNames = [''];
  List<String> regionNames = ['North'];

  Future<void> fetchPost() async {
    final response = await http.get(
        Uri.parse('${AppConfig.apiUrl}/admin/api/get-all-dropdown-values'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      speciality_list = jsonData['data']['speciality_list'];
      region_list = jsonData['data']['operating_list'];

      print(speciality_list);

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
        speciality_list = names;
        regionNames = regions;
        speciality_map = speciality_map;
        region_map = region_map;
      });

      print("region");
      print(regionNames);
      print('region_map is: ');
      print(region_map);
    } else {
      print('API request failed with status code:');
    }
  }

  Future<void> next() async {
    Map<String, dynamic> userData = {
      'username': username,
      'email': email,
      'address': address,
      'phone': phone,
      'city': city,
      'experience': experience,
      'est': est,
      'state': state,
      'speciality': speciality,
      'region': region_id,
      'user_type': user_type_id,
      'team_size': team_size,
      'core_business': core_business,
      'establishment_date': establishment_date,
      'password': password,
    };

    if (user_type_id != '1') {
      if (userData.values.any((value) => value == '')) {
        setState(() {
          error = "Please provide all the details";
        });

        return;
      }
    } else if (userData['username'] == '' ||
        userData['email'] == '' ||
        userData['address'] == '' ||
        userData['phone'] == '' ||
        userData['city'] == '' ||
        userData['experience'] == '' ||
        userData['state'] == '' ||
        userData['speciality'] == '' ||
        userData['region'] == '' ||
        userData['password'] == '' ||
        userData['establishment_date'] == '' ||
        userData['user_type'] == '') {
      setState(() {
        error = "Please provide all details";
      });

      return;
    }

    if (!isValidEmail(email) || !isValidPhoneNumber((phone))) {
      setState(() {
        error = "Please provide valid email and phone number";
      });

      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupPage1(userData: userData)),
    );
  }

  @override
  void initState() {
    super.initState();
    dateinput.text = "";
    fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
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
                          'Enter your details',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF384A59),
                            fontSize: 22,
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
                              'Full name',
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null; // Return null if the input is valid
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Your Full Name',
                            filled: true, // Enable filling the background
                            fillColor: Color.fromRGBO(245, 251, 252, 1),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10),
                          ),
                          onChanged: (value) {
                            setState(() {
                              username = value;
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
                              'Mobile number',
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Your phone number',
                            filled: true, // Enable filling the background
                            fillColor: Color.fromRGBO(245, 251, 252, 1),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10),
                          ),
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
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              phone = value;
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
                              'E-mail',
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Your Email address',
                            filled: true, // Enable filling the background
                            fillColor: Color.fromRGBO(245, 251, 252, 1),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10),
                          ),
                          onChanged: (value) {
                            setState(() {
                              email = value;
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
                        TextFormField(
                          obscureText: !show_password,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be atleast 6 digits long';
                            }
                            return null; // Return null if the input is valid
                          },
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  show_password = !show_password;
                                });
                              },
                              child: Icon(
                                show_password
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Your password',
                            filled: true, // Enable filling the background
                            fillColor: Color.fromRGBO(245, 251, 252, 1),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10),
                          ),
                          onChanged: (value) {
                            setState(() {
                              password = value;
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
                              'Address',
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null; // Return null if the input is valid
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Your address',
                            filled: true, // Enable filling the background
                            fillColor: Color.fromRGBO(245, 251, 252, 1),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10),
                          ),
                          onChanged: (value) {
                            setState(() {
                              address = value;
                            });
                          },
                        ),
                      ]),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, bottom: 5, top: 5),
                                  child: Text(
                                    'City',
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your city';
                                  }
                                  return null; // Return null if the input is valid
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hintText: 'Enter your city',
                                  filled: true, // Enable filling the background
                                  fillColor: Color.fromRGBO(245, 251, 252, 1),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    city = value;
                                  });
                                },
                              ),
                            ]),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, bottom: 5, top: 5),
                                  child: Text(
                                    'State',
                                    style: TextStyle(
                                      color: Color(0xFF312E49),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color.fromRGBO(245, 251, 252, 1),
                                ),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8),
                                    border: InputBorder.none,
                                    hintText: 'Select',
                                  ),
                                  value: state,
                                  icon: const Icon(Icons.keyboard_arrow_down),
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
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      state = newValue!;
                                    });
                                  },
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
                            padding: const EdgeInsets.all(6.0),
                            child: Column(children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, bottom: 5, top: 5),
                                  child: Text(
                                    'Total Experience',
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your phone number';
                                  } else if (value.length < 0 &&
                                      value.length > 60) {
                                    return 'Please enter a valid experience';
                                  }
                                  return null; // Return null if the input is valid
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hintText: 'Years of experience',
                                  filled: true, // Enable filling the background
                                  fillColor: Color.fromRGBO(245, 251, 252, 1),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    experience = value;
                                  });
                                },
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 5, bottom: 5, top: 5),
                            child: Text(
                              "RERA Expiry date",
                              style: TextStyle(
                                color: Color(0xFF312E49),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color.fromRGBO(245, 251, 252, 1),
                          ),
                          child: TextField(
                            controller: dateinput,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 16,
                              ),
                              border: InputBorder.none,
                              hintText: 'Select Date',
                              suffixIcon: Icon(Icons
                                  .calendar_today), // Icon on the right side
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2101),
                              );

                              if (pickedDate != null) {
                                print(pickedDate);
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(formattedDate);

                                setState(() {
                                  dateinput.text = formattedDate;
                                  establishment_date = formattedDate;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                        ),
                      ]),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, bottom: 5, top: 5),
                                  child: Text(
                                    'Operating region',
                                    style: TextStyle(
                                      color: Color(0xFF312E49),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color.fromRGBO(245, 251, 252, 1),
                                ),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8),
                                    border: InputBorder.none,
                                    hintText: 'Select Region',
                                  ),
                                  value: region,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  items: regionNames
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      region = newValue!;
                                      region_id = region_map[newValue];
                                    });
                                  },
                                ),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, bottom: 5, top: 5),
                                  child: Text(
                                    'User type',
                                    style: TextStyle(
                                      color: Color(0xFF312E49),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color.fromRGBO(245, 251, 252, 1),
                                ),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8),
                                    border: InputBorder.none,
                                    hintText: 'Company',
                                  ),
                                  value: user_type,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  items: <String>[
                                    "Individual",
                                    "Company",
                                    "Partnership",
                                    "Proprietorship"
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      user_type = newValue!;
                                      user_type_id = user_map[newValue];
                                    });
                                  },
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    user_type_id != '1'
                        ? Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 5, top: 5, bottom: 5),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Name of Establishment',
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the name of establishment';
                                  }
                                  return null; // Return null if the input is valid
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hintText: 'Name of Establishment',
                                  filled: true, // Enable filling the background
                                  fillColor: Color.fromRGBO(245, 251, 252, 1),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    est = value;
                                  });
                                },
                              ),
                            ]),
                          )
                        : Text(''),
                    user_type_id != '1'
                        ? Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 5, bottom: 5, top: 5),
                                        child: Text(
                                          'Team size',
                                          style: TextStyle(
                                            color: Color(0xFF312E49),
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Color.fromRGBO(245, 251, 252, 1),
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 8),
                                          border: InputBorder.none,
                                          hintText: 'Size',
                                        ),
                                        value: team_size,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        isExpanded: true,
                                        items: <String>[
                                          "1-5",
                                          "6-10",
                                          "11-20",
                                          "20 Above"
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            team_size = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 5, bottom: 5, top: 5),
                                        child: Text(
                                          'Core Business',
                                          style: TextStyle(
                                            color: Color(0xFF312E49),
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Color.fromRGBO(245, 251, 252, 1),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(2),
                                        child: MultiSelectDialogField(
                                            chipDisplay:
                                                MultiSelectChipDisplay.none(),
                                            buttonText: Text(
                                              "Select",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 120, 118, 118)),
                                            ),
                                            items: core_business_list
                                                .map((e) =>
                                                    MultiSelectItem(e, e))
                                                .toList(),
                                            decoration: BoxDecoration(),
                                            listType: MultiSelectListType.CHIP,
                                            buttonIcon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color.fromARGB(
                                                  255, 88, 87, 87),
                                            ),
                                            onSelectionChanged: (p0) => {
                                                  setState(() {
                                                    selected_business = p0;
                                                  })
                                                },
                                            onConfirm: (values) {
                                              print(values);

                                              setState(() {
                                                selected_business = values;
                                                core_business =
                                                    selected_business
                                                        .join(', ');
                                              });
                                              print('core business is: ');
                                              print(core_business);
                                            }),
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ],
                          )
                        : Text(''),
                    Visibility(
                      visible: selected_business
                          .isNotEmpty, // Hide if selected_business is empty
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4, bottom: 4),
                            child: Text(
                              'Selected business are:',
                              style: TextStyle(
                                fontSize: 14, // adjust the font size
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                            child: Wrap(
                              spacing: 6.0, // Adjust spacing between chips
                              runSpacing:
                                  6.0, // Adjust spacing between rows of chips
                              children: selected_business.map((category) {
                                return Chip(
                                  label: Text(category),
                                  backgroundColor: Color(0xFF376F92),
                                  labelStyle: TextStyle(color: Colors.white),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 5, bottom: 5, top: 5),
                            child: Text(
                              'Speciality',
                              style: TextStyle(
                                color: Color(0xFF312E49),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color.fromRGBO(245, 251, 252, 1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: MultiSelectDialogField(
                                chipDisplay: MultiSelectChipDisplay.none(),
                                buttonText: Text(
                                  "Select",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          Color.fromARGB(255, 120, 118, 118)),
                                ),
                                items: speciality_list
                                    .map((e) => MultiSelectItem(e, e))
                                    .toList(),
                                decoration: BoxDecoration(),
                                listType: MultiSelectListType.CHIP,
                                buttonIcon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color.fromARGB(255, 88, 87, 87),
                                ),
                                onSelectionChanged: (p0) => {
                                      setState(() {
                                        selected_speciality = p0;
                                      })
                                    },
                                onConfirm: (values) {
                                  print(values);
                                  setState(() {
                                    selected_speciality = values;
                                    speciality = speciality_map[values.first];
                                  });
                                }),
                          ),
                        )
                      ]),
                    ),
                    Visibility(
                      visible: selected_speciality
                          .isNotEmpty, // Hide if selected_speciality is empty
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4, bottom: 4),
                            child: Text(
                              'Selected Specialties are:',
                              style: TextStyle(
                                fontSize: 14, // adjust the font size
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                            child: Wrap(
                              spacing: 6.0, // Adjust spacing between chips
                              runSpacing:
                                  6.0, // Adjust spacing between rows of chips
                              children: selected_speciality.map((category) {
                                return Chip(
                                  label: Text(category),
                                  backgroundColor: Color(0xFF376F92),
                                  labelStyle: TextStyle(color: Colors.white),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          next();
                          //fetchPost();
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
                          'Next',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: error != null
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
