import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    // _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // User Avatar
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF4D4D),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 140),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/profile.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFFF7F7F7),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Container(
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Center(
                    child: Text("User Name",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(2),
                  child: Center(
                    child: Text("Username@email.com",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Center(
                      child: Text("Designation | Location",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ))),
                ),
              ]),
            ),
            // Tabs
            DefaultTabController(
              length: 4,
              child: Expanded(
                child: Column(
                  children: <Widget>[
                    loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            child: TabBar(
                                labelColor: Colors.black,
                                labelPadding:
                                    EdgeInsets.symmetric(horizontal: 8.0),
                                labelStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                ), // Adjust label font size
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorColor: Color(0xFF707070),
                                tabs: [
                                  Tab(text: "All Post"),
                                  Tab(text: "Photos"),
                                  Tab(text: "Videos"),
                                  Tab(text: "Saved"),
                                ]),
                          ),
                    Expanded(
                      child: Container(          
                        child: loading
                            ? Container()
                            : TabBarView(children: [
                                // Personal Info
                                SingleChildScrollView(
                                  child: Container(),
                                ),
                    
                                // Organization Tab
                                SingleChildScrollView(
                                  child: Container(),
                                ),
                    
                                // Document tab
                                SingleChildScrollView(
                                  child: Container(),
                                ),
                    
                                // Reference tab
                                SingleChildScrollView(
                                  child: Container(),
                                ),
                              ]),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
