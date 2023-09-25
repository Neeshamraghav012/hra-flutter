import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:hra/config/app-config.dart';

import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';

import 'dart:io';

String generateRandomName() {
  final random = Random();
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final length = 10;

  return String.fromCharCodes(
    List.generate(
        length, (index) => chars.codeUnitAt(random.nextInt(chars.length))),
  );
}

Future<String> uploadImage(XFile? image) async {
  try {
    List<int> imageBytes = File(image!.path).readAsBytesSync();

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.cloudinary.com/v1_1/hire-easy/image/upload'),
    );

    String filename = generateRandomName();

    request.fields['upload_preset'] = 'cyberbolt';
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        imageBytes,
        filename: '${filename}.jpg',
        contentType: MediaType('image', 'jpg'),
      ),
    );

    final response = await request.send();
    final responseString = await response.stream.bytesToString();

    final jsonResponse = json.decode(responseString);

    print(jsonResponse);

    if (response.statusCode == 200) {
      return jsonResponse['secure_url'];
    } else {
      return "Error";
    }
  } catch (e) {
    return "Error";
  } finally {}
}

Future<String> uploadImageBlob(XFile? image) async {
  try {
    List<int> imageBytes = File(image!.path).readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    print(base64Image);

    String randomName = generateRandomName();

    String filename = '$randomName.jpg';

    final Map<String, dynamic> requestBody = {
      "image_input": {
        "base64_image_string": base64Image,
        "image_name": filename,
        "document_type": "Posts"
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
      return jsonResponse['data'];
    } else {
      return "Error";
    }
  } catch (e) {
    return "Error";
  } finally {
    return "Uploaded";
  }
}
