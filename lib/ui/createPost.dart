import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hra/config/app-config.dart';
import 'package:hra/custom/fab_bottom_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hra/ui/newsFeedPage/NewsFeed.dart';
import 'package:hra/ui/profilePage/profile.dart';
import 'package:hra/ui/createPost.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';
import 'package:hra/ui/discoverPage.dart';
import 'package:hra/ui/notifications.dart';
import 'dart:io';

class createPage extends StatefulWidget {
  @override
  _createPageState createState() => _createPageState();
}

class _createPageState extends State<createPage> with TickerProviderStateMixin {
  int _selectedDrawerIndex = -1;
  List<MenuModel> bottomMenuItems = [];
  final ImagePicker picker = ImagePicker();
  bool isUploading = false;
  String caption = "";

  _selectedTab(int pos) {
    setState(() {
      _onSelectItem(pos);
    });

    switch (pos) {
      case 0:
        return NotificationPage();
      case 1:
        return NewsFeed();
      case 2:
        return DiscoverPage();
      case 3:
        return ProfilePage();
      default:
        return Text("Invalid screen requested");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
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

  Future<void> scanImage() async {
    var choosedimage = await picker.pickImage(source: ImageSource.camera);
  }

  Future<void> chooseImage() async {
    var choosedimage = await picker.pickImage(source: ImageSource.gallery);
  }

  Future<void> uploadImage() async {
    setState(() {
      isUploading = true;
    });
    try {
      XFile? selectedImage;

      List<int> imageBytes = File(selectedImage!.path).readAsBytesSync();
      String base64Image = base64Encode(imageBytes);

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

    bottomMenuItems.add(new MenuModel('Camera', '', Icons.camera));
    bottomMenuItems
        .add(new MenuModel('Upload Image', '', Icons.browse_gallery));
    bottomMenuItems.add(new MenuModel('Take Video', '', Icons.video_call));

    bottomMenuItems.add(new MenuModel('Add Location', '', Icons.location_city));

    _selectedTab(_selectedDrawerIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create Post',
        splashColor: Colors.teal,
        onPressed: () {
          setState(() {
            _selectedDrawerIndex = -1;
          });
        },
        child: Icon(CupertinoIcons.add),
        elevation: 0,
      ),
      bottomNavigationBar: FABBottomAppBar(
        backgroundColor: Colors.white,
        centerItemText: "",
        color: Colors.grey,
        selectedColor: Theme.of(context).colorScheme.secondary,
        notchedShape: CircularNotchedRectangle(),
        iconSize: 20.0,
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(iconData: FontAwesomeIcons.bell, text: ''),
          FABBottomAppBarItem(iconData: FontAwesomeIcons.house, text: ''),
          FABBottomAppBarItem(iconData: FontAwesomeIcons.globe, text: ''),
          FABBottomAppBarItem(iconData: FontAwesomeIcons.user, text: ''),
        ],
      ),
      body: _selectedDrawerIndex != -1
          ? _selectedTab(_selectedDrawerIndex)
          : SafeArea(
              child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 20, left: 20),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close))),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 20),
                        child: Text("Create a post",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 20),
                        child: TextButton(
                          onPressed: () {},
                          child: Text("Post",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFFF4D4D))),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 40),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('images/icon.png'),
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: TextField(
                      maxLines: 5,
                      autofocus: true,
                      onChanged: (value) => {
                        setState(() {
                          caption = value;
                        })
                      },
                      decoration: InputDecoration(
                        hintText: 'What\'s on your mind, Pranai?',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                //Spacer(),
                SizedBox(
                  height: 100,
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            decoration: new BoxDecoration(
                                color: Colors.white, //Color(0xFF737373),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: ListView.builder(
                                itemCount: bottomMenuItems.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        bottomMenuItems[index].icon,
                                        color: Colors.black,
                                      ),
                                    ),
                                    /*
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  ),*/
                                    title: Text(
                                      bottomMenuItems[index].title,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    // subtitle: Text(bottomMenuItems[index].subtitle),
                                    onTap: () {
                                      // Navigator.pop(context);
                                      scanImage();
                                      debugPrint(bottomMenuItems[index].title);
                                    },
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
    );
  }
}

class MenuModel {
  String title;
  String subtitle;
  IconData icon;

  MenuModel(this.title, this.subtitle, this.icon);
}
