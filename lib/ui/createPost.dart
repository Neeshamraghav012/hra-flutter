import 'package:flutter/material.dart';
import 'package:hra/ui/videoItem.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hra/config/app-config.dart';
import 'package:hra/custom/fab_bottom_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hra/ui/newsFeedPage/NewsFeed.dart';
import 'package:hra/ui/profilePage/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';
import 'package:hra/ui/discoverPage.dart';
import 'package:hra/ui/notifications.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:hra/ui/home.dart';
// import 'package:hra/common-services/services.dart';

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
  String image_url = "";
  XFile? uploadedContent;
  String uploadedContentType = "";
  String userId = "";
  String error = "";

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

  Future<String> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userId") ?? "";

    setState(() {
      userId = id;
    });

    return id;
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

  Future<void> choosePhotoFromCamera() async {
    var choosedimage = await picker.pickImage(source: ImageSource.camera);
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: choosedimage!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Edit your image',
            toolbarColor: Colors.red,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    setState(() {
      uploadedContent = XFile(croppedFile!.path);
      uploadedContentType = "Image";
    });
  }

  Future<void> chooseVideoFromCamera() async {
    var choosedimage = await picker.pickVideo(source: ImageSource.camera);

    setState(() {
      uploadedContent = choosedimage;
      uploadedContentType = "Video";
      _controller = VideoPlayerController.networkUrl(Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        });
    });
  }

  Future<void> choosePhotoFromGallery() async {
    var choosedMedia = await picker.pickImage(source: ImageSource.gallery);

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: choosedMedia!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Edit your image',
            toolbarColor: Colors.red,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    setState(() {
      uploadedContent = XFile(croppedFile!.path);
      uploadedContentType = "Image";
    });
  }

  Future<void> chooseVideoFromGallery() async {
    var choosedMedia = await picker.pickVideo(source: ImageSource.gallery);
    print("video selected");
    print(choosedMedia?.name);
    setState(() {
      uploadedContent = choosedMedia;
      uploadedContentType = "Video";
    });
  }

  Future<void> uploadContent(XFile? content) async {
    try {
      setState(() {
        isUploading = true; // Set the loading indicator
      });

      List<int> contentBytes = File(content!.path).readAsBytesSync();

      String base64Image = base64Encode(contentBytes);

      Map<String, dynamic> body = {};

      if (uploadedContentType == "Image") {
        String randomName = generateRandomName();

        String filename = '$randomName.jpg';

        final Map<String, dynamic> requestBody = {
          "image_input": {
            "file_type": "image",
            "base64_image_string": base64Image,
            "image_name": filename,
            "document_type": "Posts"
          }
        };

        setState(() {
          body = requestBody;
        });
      } else {
        print("video upload");

        String randomName = generateRandomName();

        String filename = '$randomName.mp4';

        final Map<String, dynamic> requestBody = {
          "image_input": {
            "file_type": "video",
            "base64_image_string": base64Image,
            "image_name": filename,
            "document_type": "Videos"
          }
        };

        setState(() {
          body = requestBody;
        });
      }

      print(body);
      final response = await http.post(
        Uri.parse('${AppConfig.apiUrl}/admin/api/file-upload-base64'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
      final jsonResponse = json.decode(response.body);

      print(jsonResponse);

      if (response.statusCode == 200) {
        setState(() {
          image_url = jsonResponse['data'];
        });
        print('File uploaded successfully');
      } else {
        setState(() {
          error = jsonResponse['message'];
          isUploading = false;
        });
        print('File upload failed');
      }
    } catch (e) {
      setState(() {
        isUploading = false;
        error = "Something went wrong please try again.";
      });
      print('Error uploading file: $e');
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  Future<void> post() async {
    setState(() {
      isUploading = true;
    });
    try {
      if (uploadedContent != null) {
        await uploadContent(uploadedContent);
      }

      print("image url is: ");
      print(image_url);
      final response = await http.post(
        Uri.parse('${AppConfig.apiUrl}/socialmedia/api/post'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "post_input": {
            "user_id": userId,
            "title": caption,
            "description": " ",
            "content": " ",
            "views_count": 0,
            "created_by": userId,
            "updated_by": userId,
            "post_attachments": [
              {
                "name": "Posts",
                "document_number": " ",
                "document_path": image_url,
                "document_type": "Posts",
                "created_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a",
                "updated_by": "6957752d-9c8e-41b5-b17d-17111c3ed06a"
              }
            ]
          }
        }),
      );
      final jsonResponse = json.decode(response.body);

      print(jsonResponse);
      if (jsonResponse['status']) {
        setState(() {
          isUploading = false;
        });

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage(index: 1)));
      } else {
        print('Post request failed');
      }
    } catch (e) {
      print('Error uploading post: $e');
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();

    bottomMenuItems.add(new MenuModel('Camera', 'camera', Icons.camera));
    bottomMenuItems.add(new MenuModel(
        'Upload Photo from Gallery', 'scan_photo', Icons.browse_gallery));
    bottomMenuItems.add(new MenuModel('Upload video from Gallery', 'scan_video',
        Icons.video_library_outlined));
    bottomMenuItems.add(new MenuModel('Take Video', 'video', Icons.video_call));

    // bottomMenuItems.add(new MenuModel('Add Location', '', Icons.location_city));

    _selectedTab(_selectedDrawerIndex);

    getUser();
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
                          onPressed: () {
                            var snackdemo = SnackBar(
                              content: Text("Posting your updates"),
                              backgroundColor: Colors.green,
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(5),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackdemo);
                            post();
                            // uploadImage(uploadedContent);
                            // Navigator.pop(context);
                          },
                          child: isUploading
                              ? CircularProgressIndicator()
                              : Text("Post",
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
                  height: 100,
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

                Container(
                  child: uploadedContent != null
                      ? Container(
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: AspectRatio(
                              aspectRatio: 16 / 8,
                              child: uploadedContentType == "Image"
                                  ? Image.file(
                                      File(uploadedContent!.path),
                                      fit: BoxFit.cover,
                                      height: 200,
                                    )
                                  : VideoItems(
                                      videoPlayerController:
                                          VideoPlayerController.file(
                                              File(uploadedContent!.path)),
                                      looping: true,
                                      autoplay: true),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 100,
                        ),
                ),
                Center(
                  child: Text(error),
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
                                      if (bottomMenuItems[index].subtitle ==
                                          'camera') {
                                        choosePhotoFromCamera();
                                      } else if (bottomMenuItems[index]
                                              .subtitle ==
                                          'scan_photo') {
                                        choosePhotoFromGallery();
                                      } else if (bottomMenuItems[index]
                                              .subtitle ==
                                          'scan_video') {
                                        chooseVideoFromGallery();
                                      } else {
                                        chooseVideoFromCamera();
                                      }
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
