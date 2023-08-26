import 'package:flutter/material.dart';
import 'package:hra/forgot-password.dart';
import 'dart:convert';
import 'package:hra/login.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:hra/signup2.dart';

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

class SignupPage1 extends StatefulWidget {
  final Map<String, dynamic> userData; // Add this line

  SignupPage1({required this.userData});

  @override
  _SignupPage1State createState() => _SignupPage1State(userData: userData);
}

class _SignupPage1State extends State<SignupPage1> {
  final Map<String, dynamic> userData;
  _SignupPage1State({required this.userData});

  String doc = 'PAN';
  String doc_no = "";
  String doc_url = "";

  String selectedState = '';

  XFile? uploadimage; //variable for choosed file
  final ImagePicker picker = ImagePicker();
  bool isUploading = false;
  bool uploaded = false;

  Future<void> chooseImage() async {
    var choosedimage = await picker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage;
    });
  }

  Future<void> scanImage() async {
    var choosedimage = await picker.pickImage(source: ImageSource.camera);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage;
    });
  }

  Future<void> p() async {
    print("user datas i: " + this.userData['user_type']);
  }

  Future<void> next() async {
    Map<String, dynamic> docData = {
      "doc": doc,
      "doc_no": doc_no,
      "doc_url": doc_url,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SignupPage2(userData: this.userData, docData: docData)),
    );
  }

  Future<void> uploadImage() async {
    try {
      setState(() {
        isUploading = true; // Set the loading indicator
      });

      List<int> imageBytes = File(uploadimage!.path).readAsBytesSync();

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.cloudinary.com/v1_1/hire-easy/image/upload'),
      );

      request.fields['upload_preset'] = 'cyberbolt';
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          imageBytes,
          filename: 'image.jpg',
          contentType: MediaType('image', 'jpg'),
        ),
      );

      final response = await request.send();
      final responseString = await response.stream.bytesToString();

      final jsonResponse = json.decode(responseString);

      if (response.statusCode == 200) {
        print('File uploaded successfully');
        print("secure url is: " + jsonResponse['secure_url']);
        setState(() {
          doc_url = jsonResponse['secure_url'];
        });
      } else {
        print('File upload failed');
      }
    } catch (e) {
      print('Error uploading file: $e');
    } finally {
      setState(() {
        isUploading = false;
        uploaded = true; // Reset the loading indicator
      });
    }
  }

  @override
  void initState() {
    p();
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
                              setState(() {
                                doc = "PAN";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color: Color(
                                    0xFFFF4D4D), // Specify the border color
                                width: 2.0, // Specify the border width
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            child: Text(
                              'PAN Card',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFFF4D4D),
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
                              setState(() {
                                doc = "Aadhar";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color: Color(
                                    0xFFFF4D4D), // Specify the border color
                                width: 2.0, // Specify the border width
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            child: Text(
                              'Aadhar Card',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFFF4D4D),
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
                              setState(() {
                                doc = "RERA";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color: Color(
                                    0xFFFF4D4D), // Specify the border color
                                width: 2.0, // Specify the border width
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            child: Text(
                              'RERA',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFFF4D4D),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 10, left: 5),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                doc = "Profile Picture";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color: Color(
                                    0xFFFF4D4D), // Specify the border color
                                width: 2.0, // Specify the border width
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            child: Text(
                              'Profile Picture',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFFF4D4D),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: doc,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintText: 'Your ${doc}'),
                        onChanged: (value) {
                          setState(() {
                            doc_no = value;
                          });
                        },
                      ),
                    ),
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
                      child: uploadimage == null
                          ? Container()
                          : Container(
                              child: SizedBox(
                                height: 150,
                                width: 200,
                                child: Image.file(
                                  File(uploadimage!.path),
                                ),
                              ),
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top:20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  scanImage(); // call choose image function
                                },
                                icon: Icon(Icons.camera),
                                label: Text("Scan now"),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF1E77CC), // Set the background color here
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  chooseImage(); // call choose image function
                                },
                                icon: Icon(Icons.folder_open),
                                label: Text("Browse files"),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF1E77CC), // Set the background color here
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                ),
                              ),
                            ),
                          ),

                          // Add some spacing
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Container(
                        child: uploaded
                            ? Text("Image Uploaded!")
                            : uploadimage == null
                                ? SizedBox()
                                : isUploading
                                    ? Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: CircularProgressIndicator(),
                                      )
                                    : ElevatedButton.icon(
                                        onPressed: () {
                                          uploadImage();
                                        },
                                        icon: Icon(Icons.file_upload),
                                        label: Text("UPLOAD IMAGE"),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(
                                              0xFF3C3C3C), // Set the background color here
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
