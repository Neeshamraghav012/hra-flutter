import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hra/custom/fab_bottom_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hra/ui/newsFeedPage/NewsFeed.dart';
import 'package:hra/ui/profilePage/profile.dart';
import 'package:hra/ui/createPost.dart';
import 'package:hra/ui/discoverPage.dart';
import 'package:hra/ui/notifications.dart';

class HomePage extends StatefulWidget {
  final int index;

  HomePage({required this.index});
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedDrawerIndex = 1;
  List<MenuModel> bottomMenuItems = [];

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

  @override
  void initState() {
    super.initState();

    // _selectedTab(_selectedDrawerIndex);
    _selectedTab(widget.index);
    bottomMenuItems.add(new MenuModel('Camera', '', Icons.camera));
    bottomMenuItems
        .add(new MenuModel('Upload Image', '', Icons.browse_gallery));
    bottomMenuItems.add(new MenuModel('Take Video', '', Icons.video_call));

    bottomMenuItems.add(new MenuModel('Add Location', '', Icons.location_city));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _selectedTab(_selectedDrawerIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create Post',
        splashColor: Colors.teal,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => createPage()),
          );
          return;
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
    );
  }

  _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 440.0,
            color: Color(0xFF737373),
            child: Column(
              children: <Widget>[
                Container(
                  height: 250.0,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: new BoxDecoration(
                      color: Colors.white, //Color(0xFF737373),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: ListView.builder(
                      itemCount: bottomMenuItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
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
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          // subtitle: Text(bottomMenuItems[index].subtitle),
                          onTap: () {
                            Navigator.pop(context);
                            debugPrint(bottomMenuItems[index].title);
                          },
                        );
                      }),
                ),

                //SizedBox(height: 10),

                Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.close,
                            size: 25, color: Colors.grey[900]))),
              ],
            ),
          );
        });
  }
}

class MenuModel {
  String title;
  String subtitle;
  IconData icon;

  MenuModel(this.title, this.subtitle, this.icon);
}
