import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:hra/payments/verify-payment.dart';
import 'dart:math';
import 'package:hra/config/app-config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadPaymentPage extends StatefulWidget {
  @override
  State<UploadPaymentPage> createState() => _UploadPaymentPageState();
}

class _UploadPaymentPageState extends State<UploadPaymentPage> {
  XFile? uploadimage;
  final ImagePicker picker = ImagePicker();
  bool isUploading = false;
  bool uploaded = false;
  String payment_link = "";
  String user_id = "";

  Future<void> chooseImage() async {
    var choosedimage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      uploadimage = choosedimage;
    });
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

  Future<void> uploadImage() async {
    setState(() {
      isUploading = true;
    });
    try {
      XFile? selectedImage;

      List<int> imageBytes = File(uploadimage!.path).readAsBytesSync();
      String base64Image = base64Encode(imageBytes);

      print(base64Image);

      String randomName = generateRandomName();

      String filename = '$randomName.jpg';

      final Map<String, dynamic> requestBody = {
        "image_input": {
          "base64_image_string": base64Image,
          "image_name": filename,
          "document_type": "payments"
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
          payment_link = jsonResponse['data'];
        });

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        user_id = prefs.getString("userId")!;
        print(user_id);

        final response_payment = await http.get(
          Uri.parse(
              '${AppConfig.apiUrl}/user/api/user_payment_completion_status?user_id=${user_id}&payment_link=${payment_link}'),
          headers: {
            'Content-Type': 'application/json',
          },
        );

        final res = json.decode(response_payment.body);

        print(res);

        setState(() {
          isUploading = false;
          uploaded = true;
        });

      } else {
        print('File upload failed');
        setState(() {
          isUploading = false;
        });
      }
    } catch (e) {
      setState(() {
        isUploading = false;
      });
      print('Error uploading file: $e');
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text("Upload the screenshot of the payment.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ),
                Container(
                  child: uploadimage != null
                      ? Container(
                          child: SizedBox(
                            height: 150,
                            width: 200,
                            child: Image.file(
                              File(uploadimage!.path),
                            ),
                          ),
                        )
                      : Container(),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        chooseImage();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            //borderRadius: BorderRadius.circular(30),

                            ),
                        backgroundColor: Color.fromARGB(255, 3, 63, 142),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                      child: Text(
                        'Browse Files',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                uploadimage != null
                    ? uploaded
                        ? Center(
                            child: Padding(padding: EdgeInsets.all(6.0), child: Text('Image uploaded, wait for admin\'s approval!')),
                          )
                        : isUploading
                            ? Padding(padding: EdgeInsets.all(6.0), child: CircularProgressIndicator())
                            : Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    uploadImage();
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
                                    'Upload Now',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
