import 'package:flutter/material.dart';
import 'package:hra/forgot-password.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hra/signup1.dart';
import 'package:hra/login.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
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
  String? core_buisness;
  String establishment_date = "";
  String password = "";
  String error = "";
  String region_id = "138f3a4d-83ff-4ddc-93f2-ef15e5d4f3d4";

  // Dropdown lists
  List speciality_list = [];
  List region_list = [];

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
    final response = await http.get(Uri.parse(
        'https://hra-api-dev.azurewebsites.net/admin/api/get-all-dropdown-values'));

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
      'user_type': user_type,
      'team_size': team_size,
      'core_buisness': core_buisness,
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
    }
    else if (userData['username'] == '' || userData['email'] == '' || userData['address'] == '' || userData['phone'] == '' || userData['city'] == ''
    || userData['experience'] == '' || userData['state'] == '' || userData['speciality'] == '' || userData['region'] == '' || userData['password'] == ''
    || userData['establishment_date'] == '' || userData['user_type'] == ''){

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
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Your Full Name'),
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
                        TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Your phone number'),
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
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Your Email address'),
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
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Your password'),
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
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Your address'),
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
                              TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter your city',
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
                                height: 57,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8),
                                    border: InputBorder.none,
                                    hintText: 'select',
                                  ),
                                  value: state,
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
                                        style: TextStyle(fontSize: 12),
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
                              TextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Years of experience',
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
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: MultiSelectDialogField(
                                    items: speciality_list
                                        .map((e) => MultiSelectItem(e, e))
                                        .toList(),
                                    decoration: BoxDecoration(),
                                    listType: MultiSelectListType.LIST,
                                    onConfirm: (values) {
                                      speciality = speciality_map[values.first];
                                    }),
                              )
                            ]),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10, left: 15),
                      child: TextField(
                        controller:
                            dateinput, //editing controller of this TextField
                        decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "RERA Expiry date", //label text of field

                          border: OutlineInputBorder(),
                          hintText: 'Select Date',
                        ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

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
                                height: 57,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8),
                                    border: InputBorder.none,
                                    hintText: 'select region',
                                  ),
                                  value: region,
                                  isExpanded: true,
                                  items: regionNames
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(fontSize: 12),
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
                                height: 57,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8),
                                    border: InputBorder.none,
                                    hintText: 'Company',
                                  ),
                                  value: user_type,
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
                                        style: TextStyle(fontSize: 12),
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
                              TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Name of Establishment'),
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
                                      height: 57,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 8),
                                          border: InputBorder.none,
                                          hintText: 'size',
                                        ),
                                        value: team_size,
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
                                              style: TextStyle(fontSize: 12),
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
                                      height: 57,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 8),
                                          border: InputBorder.none,
                                          hintText: 'Business type',
                                        ),
                                        value: core_buisness,
                                        isExpanded: true,
                                        items: <String>[
                                          "Primary",
                                          "Secondary",
                                          "Lease",
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            core_buisness = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ],
                          )
                        : Text(''),
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
