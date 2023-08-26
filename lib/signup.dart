import 'package:flutter/material.dart';
import 'package:hra/forgot-password.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hra/signup1.dart';
import 'package:hra/login.dart';
import 'package:intl/intl.dart';

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
          title: Text('Register'),
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
  // input values

  String username = "";
  String email = "";
  String address = "";
  String phone = "";
  String city = "";
  String experience = "";
  String est = "";
  String state = "Haryana";
  String speciality = "Residential";
  String region = "North";
  String user_type = "Company";
  String team_size = "1-5";
  String core_buisness = "Primary";
  String establishment_date = "";

  // Dropdown lists
  List state_list = [];
  List speciality_list = [];
  List region_list = [];
  List user_type_list = [];
  List team_size_list = [];
  List core_buiness_list = [];

  TextEditingController dateinput = TextEditingController();
  List<String> specialityNames = [];

    Future<void> fetchPost() async {
      final response = await http.get(
          Uri.parse('https://hra-api-dev.azurewebsites.net/admin/api/get-all-dropdown-values'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        speciality_list = jsonData['data']['speciality_list'];
        List<String> names = speciality_list
            .where((item) => item['name'] != null)
            .map<String>((item) => item['name'])
            .toList();

        setState(() {
          specialityNames = names;
        });
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
      'region': region,
      'user_type': user_type,
      'team_size': team_size,
      'core_buisness': core_buisness,
      'establishment_date': establishment_date,
    };

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupPage1(userData: userData)),
    );
  }

  @override
  void initState() {
    dateinput.text = "";
    fetchPost();
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
                          'Enter your details',
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
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Full name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintText: 'Your Full Name'),
                        onChanged: (value) {
                          setState(() {
                            username = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Mobile number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: 'Your Phone number',
                        ),
                        onChanged: (value) {
                          setState(() {
                            phone = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: 'Your Email address',
                        ),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: 'Enter your address',
                        ),
                        onChanged: (value) {
                          setState(() {
                            address = value;
                          });
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'City',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: 'Enter your city',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  city = value;
                                });
                              },
                            ),
                          ),
                        ),
                        // Add some spacing

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8),
                                  labelText: 'State',
                                  border: InputBorder.none,
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
                                ].map<DropdownMenuItem<String>>((String value) {
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
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Total Experience',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: 'Years of experience',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    experience = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8),
                                  labelText: 'Speciality',
                                  border: InputBorder.none,
                                ),
                                value: speciality,
                                isExpanded: true,
                                items: specialityNames
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
                                    speciality = newValue!;
                                  });
                                },
                              ),
                            ),
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

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: 'Select Date',
                        ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
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
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 5),
                                  labelText:
                                      'Operating region', // Set your label text here
                                  border: InputBorder
                                      .none, // Remove the default underline
                                ),
                                value: region,
                                isExpanded: true,
                                items: <String>[
                                  "East",
                                  "West",
                                  "North",
                                  "South"
                                ].map<DropdownMenuItem<String>>((String value) {
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
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 5),
                                  labelText:
                                      'User type', // Set your label text here
                                  border: InputBorder
                                      .none, // Remove the default underline
                                ),
                                value: user_type,
                                isExpanded: true,
                                items: <String>[
                                  "Individual",
                                  "Company",
                                  "Proprietorship",
                                  "Partnership",
                                ].map<DropdownMenuItem<String>>((String value) {
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
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Name of Establishment',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: 'Name of Establishment',
                        ),
                        onChanged: (value) {
                          setState(() {
                            est = value;
                          });
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 5),
                                  labelText:
                                      'Team size', // Set your label text here
                                  border: InputBorder
                                      .none, // Remove the default underline
                                ),
                                value: team_size,
                                isExpanded: true,
                                items: <String>[
                                  "1-5",
                                  "6-10",
                                  "11-20",
                                  "20 Above",
                                ].map<DropdownMenuItem<String>>((String value) {
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
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 5),
                                  labelText:
                                      'Core Business', // Set your label text here
                                  border: InputBorder
                                      .none, // Remove the default underline
                                ),
                                value: core_buisness,
                                isExpanded: true,
                                items: <String>[
                                  "Primary",
                                  "Secondary",
                                  "Lease",
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  core_buisness = newValue!;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          next();
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
