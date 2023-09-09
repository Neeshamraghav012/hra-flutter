import 'package:flutter/material.dart';
import 'package:hra/forgot-password.dart';
import 'dart:convert';
import 'package:hra/login.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:hra/signup2.dart';
import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:hra/app-config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hra/admin.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(150);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFF4D4D),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
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

class SignupPage1 extends StatefulWidget {
  final Map<String, dynamic> userData;

  SignupPage1({required this.userData});

  @override
  _SignupPage1State createState() => _SignupPage1State(userData: userData);
}

class _SignupPage1State extends State<SignupPage1> {
  final Map<String, dynamic> userData;
  _SignupPage1State({required this.userData});

  String doc = 'PAN';
  String uploaded = "";
  String? doc_name;
  String doc_no = "";
  String doc_url = "";
  String error = "";

  String pan_number = "";
  String pan_url = "";

  String aadhar_number = "";
  String aadhar_url = "";

  String rera_number = "";
  String rera_url = "";

  String profile_url = "";

  bool aadhar_uploaded = false;
  bool pan_uploaded = false;
  bool rera_uploaded = false;
  bool profile_uploaded = false;

  XFile? uploadimage;
  final ImagePicker picker = ImagePicker();
  bool isUploading = false;
  XFile? aadhar_image;
  XFile? pan_image;
  XFile? rera_image;
  XFile? profile_image;
  TextEditingController textFieldController = TextEditingController();

  Future<void> chooseImage(String doc) async {
    var choosedimage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (doc == 'PAN') {
        pan_image = choosedimage;
      } else if (doc == 'Aadhar') {
        aadhar_image = choosedimage;
      } else if (doc == 'RERA') {
        rera_image = choosedimage;
      } else {
        profile_image = choosedimage;
      }
    });
  }

  Future<void> saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("pan_number", pan_number);
    await prefs.setString("aadhar_number", aadhar_number);
    await prefs.setString("rera_number", rera_number);
  }

  Future<void> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    pan_number = prefs.getString('pan_number')!;
    aadhar_number = prefs.getString('aadhar_number')!;
    rera_number = prefs.getString('aadhar_number')!;
  }

  Future<void> scanImage(String doc) async {
    var choosedimage = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (doc == 'PAN') {
        pan_image = choosedimage;
      } else if (doc == 'Aadhar') {
        aadhar_image = choosedimage;
      } else if (doc == 'RERA') {
        rera_image = choosedimage;
      } else {
        profile_image = choosedimage;
      }
    });
  }

  Future<void> next() async {
    Map<String, dynamic> docData = {
      "aadhar_number": aadhar_number,
      "aadhar_url": aadhar_url,
      "profile_url": profile_url,
      "pan_url": pan_url,
      "pan_number": pan_number,
      "rera_number": rera_number,
      "rera_url": rera_url,
    };



    print(pan_number);
    print(aadhar_number);
    print(rera_number);

    print(pan_image);
    print(aadhar_image);
    print(rera_image);
    print(profile_image);

    print(pan_url);
    print(aadhar_url);
    print(rera_url);
    print(profile_url);

    print(doc);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SignupPage2(docData: docData, userData: userData)),
    );
  }

  String generateRandomName() {
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final length = 10;

    return String.fromCharCodes(
      List.generate(
          length, (index) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  Future<void> uploadImage(String doc) async {
    setState(() {
      isUploading = true;
    });
    try {
      XFile? selectedImage;

      if (doc == 'PAN') {
        if (pan_image == null) {
          error = "Please select an image";
          return;
        }
        selectedImage = pan_image;
      } else if (doc == 'Aadhar') {
        if (aadhar_image == null) {
          error = "Please select an image";
          return;
        }
        selectedImage = aadhar_image;
      } else if (doc == 'RERA') {
        if (rera_image == null) {
          error = "Please select an image";
          return;
        }
        selectedImage = rera_image;
      } else if (doc == 'Profile') {
        if (profile_image == null) {
          error = "Please select an image";
          return;
        }
        selectedImage = profile_image;
      } else {
        error = "Unknown document type";
        return;
      }

      List<int> imageBytes = File(selectedImage!.path).readAsBytesSync();
      String base64Image = base64Encode(imageBytes);

      print(base64Image);

      String randomName = generateRandomName();

      String filename = '$randomName.jpg';

      final Map<String, dynamic> requestBody = {
        "image_input": {
          "base64_image_string": base64Image,
          "image_name": filename,
          "document_type": "documents"
        }
      };

      final response = await http.post(
        Uri.parse('${AppConfig.apiUrl}/admin/api/file-upload-base64'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );
      final jsonResponse = json.decode(response.body);

      if (jsonResponse['status']) {
        setState(() {
          if (doc == 'PAN') {
            pan_url = jsonResponse['data'];
            uploaded = 'PAN';
            pan_uploaded = true;
          } else if (doc == 'Aadhar') {
            aadhar_url = jsonResponse['data'];
            uploaded = 'Aadhar';
            aadhar_uploaded = true;
          } else if (doc == 'RERA') {
            rera_url = jsonResponse['data'];
            uploaded = 'RERA';
            rera_uploaded = true;
          } else {
            profile_url = jsonResponse['data'];
            uploaded = 'Profile';
            profile_uploaded = true;
          }
        });
      } else {
        print('File upload failed');
      }
    } catch (e) {
      print('Error uploading file: $e');
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  void cancelImage(String doc) {
    try {
      if (doc == 'PAN') {
        if (pan_image == null) {
          error = "Please select an image";
          return;
        }
        setState(() {
          pan_image = null;
          pan_uploaded = false;
          pan_url = '';
        });
      } else if (doc == 'Aadhar') {
        if (aadhar_image == null) {
          error = "Please select an image";
          return;
        }
        setState(() {
          aadhar_image = null;
          aadhar_uploaded = false;
          aadhar_url = '';
        });
      } else if (doc == 'RERA') {
        if (rera_image == null) {
          error = "Please select an image";
          return;
        }
        setState(() {
          rera_image = null;
          rera_uploaded = false;
          rera_url = '';
        });
      } else if (doc == 'Profile') {
        if (profile_image == null) {
          error = "Please select an image";
          return;
        }
        setState(() {
          profile_image = null;
          profile_uploaded = false;
          profile_url = '';
        });
      } else {
        error = "Unknown document type";
        return;
      }
    } finally {
      print("");
    }
  }

  @override
  void initState() {
    super.initState();

    // Set the initial controller text based on doc
    if (doc == 'PAN') {
      textFieldController.text = pan_number;
    } else if (doc == 'Aadhaar') {
      textFieldController.text = aadhar_number;
    } else if (doc == 'RERA') {
      textFieldController.text = rera_number;
    }
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
                          'Document Verification',
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
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: ElevatedButton(
                            onPressed: () {
                              textFieldController.text = pan_number;

                              setState(() {
                                doc = "PAN";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: doc == "PAN"
                                  ? Color(0xFF376F92)
                                  : Color(0xFFD3DFE7),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            child: Text(
                              'PAN Card',
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    doc == "PAN" ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: ElevatedButton(
                            onPressed: () {
                              textFieldController.text = aadhar_number;

                              setState(() {
                                doc = "Aadhar";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: doc == "Aadhar"
                                  ? Color(0xFF376F92)
                                  : Color(0xFFD3DFE7),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            child: Text(
                              'Aadhar Card',
                              style: TextStyle(
                                fontSize: 12,
                                color: doc == "Aadhar"
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: ElevatedButton(
                            onPressed: () {
                              textFieldController.text = rera_number;
                              setState(() {
                                doc = "RERA";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: doc == "RERA"
                                  ? Color(0xFF376F92)
                                  : Color(0xFFD3DFE7),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            child: Text(
                              'RERA',
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    doc == "RERA" ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              doc = "Profile";
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: doc == "Profile"
                                ? Color(0xFF376F92)
                                : Color(0xFFD3DFE7),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                          ),
                          child: Text(
                            'Profile Picture',
                            style: TextStyle(
                              fontSize: 12,
                              color: doc == "Profile"
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    doc != 'Profile'
                        ? Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 5, top: 5, bottom: 5),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    '${doc} number',
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
                                controller: textFieldController,
                                textCapitalization:
                                    doc == 'PAN' || doc == 'RERA'
                                        ? TextCapitalization.characters
                                        : TextCapitalization.none,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter valid ${doc} number';
                                  } else if (doc == 'Aadhar') {
                                    if (value.length != 16) {
                                      return 'Please enter 16 digits aadhar number';
                                    }
                                  } else if (doc == 'PAN') {
                                    if (value.length != 10) {
                                      return 'Please enter 10 digits pan number';
                                    }
                                  }

                                  return null; // Return null if the input is valid
                                },
                                inputFormatters: doc == "Aadhar"
                                    ? [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]'))
                                      ]
                                    : [],
                                keyboardType: doc == "Aadhar"
                                    ? TextInputType.number
                                    : TextInputType.text,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Your ${doc}'),
                                onChanged: (value) {
                                  setState(() {
                                    if (doc == "PAN") {
                                      pan_number = value;
                                    } else if (doc == "Aadhar") {
                                      aadhar_number = value;
                                    } else if (doc == "RERA") {
                                      rera_number = value;
                                    }
                                  });
                                },
                              ),
                            ]),
                          )
                        : Text(''),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 20, bottom: 20),
                        child: Text(
                          "Upload ID Proof",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: doc == 'PAN' && pan_image != null
                          ? Container(
                              child: Padding(
                                padding: EdgeInsets.all(6.0),
                                child: AspectRatio(
                                  aspectRatio: 16 / 6,
                                  child: Image.file(
                                    File(pan_image!.path),
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    Container(
                      child: doc == 'RERA' && rera_image != null
                          ? Container(
                              child: Padding(
                                padding: EdgeInsets.all(6.0),
                                child: AspectRatio(
                                  aspectRatio: 16 / 6,
                                  child: Image.file(
                                    File(rera_image!.path),
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    Container(
                      child: doc == 'Aadhar' && aadhar_image != null
                          ? Container(
                              child: Padding(
                                padding: EdgeInsets.all(6.0),
                                child: AspectRatio(
                                  aspectRatio: 16 / 6,
                                  child: Image.file(
                                    File(aadhar_image!.path),
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    Container(
                      child: doc == 'Profile' && profile_image != null
                          ? Container(
                              child: Padding(
                                padding: EdgeInsets.all(6.0),
                                child: AspectRatio(
                                  aspectRatio: 16 / 6,
                                  child: Image.file(
                                    File(profile_image!.path),
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    Buttons(doc),
                    pan_image != null && doc == 'PAN'
                        ? Info(
                            val: "pan",
                            onButtonPressed: () {
                              cancelImage(doc);
                            },
                            onUploadPressed: () {
                              uploadImage(doc);
                            },
                            isloading: isUploading,
                            isuploaded: pan_uploaded,
                          )
                        : Container(),
                    aadhar_image != null && doc == 'Aadhar'
                        ? Info(
                            val: "aadhar",
                            onButtonPressed: () {
                              cancelImage(doc);
                            },
                            onUploadPressed: () {
                              uploadImage(doc);
                            },
                            isloading: isUploading,
                            isuploaded: aadhar_uploaded,
                          )
                        : Container(),
                    rera_image != null && doc == 'RERA'
                        ? Info(
                            val: "rera",
                            onButtonPressed: () {
                              cancelImage(doc);
                            },
                            onUploadPressed: () {
                              uploadImage(doc);
                            },
                            isloading: isUploading,
                            isuploaded: rera_uploaded,
                          )
                        : Container(),
                    profile_image != null && doc == 'Profile'
                        ? Info(
                            val: "profile",
                            onButtonPressed: () {
                              cancelImage(doc);
                            },
                            onUploadPressed: () {
                              uploadImage(doc);
                            },
                            isloading: isUploading,
                            isuploaded: profile_uploaded,
                          )
                        : Container(),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          next();
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

  Padding Buttons(String doc) {
    if (doc == 'PAN') {
      if (pan_image != null) {
        return Padding(padding: EdgeInsets.all(0));
      }
    }
    if (doc == 'Aadhar') {
      if (aadhar_image != null) {
        return Padding(padding: EdgeInsets.all(0));
      }
    }
    if (doc == 'RERA') {
      if (rera_image != null) {
        return Padding(padding: EdgeInsets.all(0));
      }
    }
    if (doc == 'Profile') {
      if (profile_image != null) {
        return Padding(padding: EdgeInsets.all(0));
      }
    }
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: SizedBox(
                height: 150,
                width: 200,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: DottedBorder(
                    color: Colors.blueGrey,
                    strokeWidth: 3,
                    dashPattern: [10, 6],
                    child: ElevatedButton(
                      onPressed: () {
                        scanImage(doc);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 249, 250, 250),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/camera.jpeg',
                            height: 50,
                            width: 150,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Scan now",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 150,
              width: 150,
              child: Container(
                padding: EdgeInsets.all(20),
                child: DottedBorder(
                  color: Colors.blueGrey,
                  strokeWidth: 3,
                  dashPattern: [10, 6],
                  child: ElevatedButton(
                    onPressed: () {
                      chooseImage(doc);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 249, 250, 250),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/browse.jpeg',
                          height: 50,
                          width: 150,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Browse files",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  final dynamic val;
  final VoidCallback onButtonPressed;
  final Function()? onUploadPressed;
  final bool isloading;
  final bool isuploaded;

  const Info(
      {Key? key,
      required this.val,
      required this.onButtonPressed,
      this.onUploadPressed,
      required this.isloading,
      required this.isuploaded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 5),
      child: Row(
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.file_copy, color: Color(0xFF1E77CC)),
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    '${val}.jpg',
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
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Container(
                    width: 40, // Adjust the width as needed
                    height: 40,
                    // Adjust the height as needed
                    child: ElevatedButton(
                      onPressed: () {
                        onButtonPressed();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF1E77CC)),
                        shape: MaterialStateProperty.all<CircleBorder>(
                          CircleBorder(), // Make it circular
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero,
                        ),
                      ),
                      child: Icon(
                        Icons.close,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            width: 250,
            height: 50,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  color: Color.fromARGB(255, 112, 116, 120),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          // Spacer(),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: isuploaded
                ? Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text("Uploaded!"))
                : isloading
                    ? Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () {
                          onUploadPressed!();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFA1FF89), // Background color

                          padding: EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 15,
                          ),
                        ),
                        child: Text(
                          'Upload',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black, // Text color
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
