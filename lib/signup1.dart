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

    if (profile_url == '' ||
        pan_url == '' ||
        aadhar_url == '' ||
        rera_url == '' ||
        pan_number == '' ||
        aadhar_number == '' ||
        rera_number == '') {
      setState(() {
        error = "Please provide all the details";
      });
      return;
    }

    print(pan_number);
    print(aadhar_number);
    print(rera_number);
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
          } else if (doc == 'Aadhar') {
            aadhar_url = jsonResponse['data'];
            uploaded = 'Aadhar';
          } else if (doc == 'RERA') {
            rera_url = jsonResponse['data'];
            uploaded = 'RERA';
          } else {
            profile_url = jsonResponse['data'];
            uploaded = 'Profile';
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
                                  ? Color(0xFFA1FF89)
                                  : Color(0xFFD3DFE7),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            child: Text(
                              'PAN Card',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
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
                                  ? Color(0xFFA1FF89)
                                  : Color(0xFFD3DFE7),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            child: Text(
                              'Aadhar Card',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
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
                                  ? Color(0xFFA1FF89)
                                  : Color(0xFFD3DFE7),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            child: Text(
                              'RERA',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
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
                                ? Color(0xFFA1FF89)
                                : Color(0xFFD3DFE7),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                          ),
                          child: Text(
                            'Profile Picture',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
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
                              TextField(
                                controller: textFieldController,
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
                              child: SizedBox(
                                height: 150,
                                width: 200,
                                child: Image.file(
                                  File(pan_image!.path),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    Container(
                      child: doc == 'RERA' && rera_image != null
                          ? Container(
                              child: SizedBox(
                                height: 150,
                                width: 200,
                                child: Image.file(
                                  File(rera_image!.path),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    Container(
                      child: doc == 'Aadhar' && aadhar_image != null
                          ? Container(
                              child: SizedBox(
                                height: 150,
                                width: 200,
                                child: Image.file(
                                  File(aadhar_image!.path),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    Container(
                      child: doc == 'Profile' && profile_image != null
                          ? Container(
                              child: SizedBox(
                                height: 150,
                                width: 200,
                                child: Image.file(
                                  File(profile_image!.path),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    Padding(
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
                                        primary:
                                            Color.fromARGB(255, 249, 250, 250),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'images/camera.jpeg',
                                            height: 30,
                                            width: 80,
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            "Scan now",
                                            style:
                                                TextStyle(color: Colors.black),
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
                                      primary:
                                          Color.fromARGB(255, 249, 250, 250),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'images/browse.jpeg',
                                          height: 30,
                                          width: 80,
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Container(
                        child: uploaded != null && uploaded == doc
                            ? Text("Image Uploaded!")
                            : isUploading
                                ? CircularProgressIndicator()
                                : ElevatedButton.icon(
                                    onPressed: () {
                                      if (doc != null) {
                                        uploadImage(doc);
                                      }
                                    },
                                    icon: Icon(Icons.file_upload),
                                    label: Text("UPLOAD IMAGE"),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF3C3C3C),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                    ),
                                  ),
                      ),
                    ),
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
}
