import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFF4D4D),
      elevation: 0,
      title: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, right: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'View Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0); // Top-right corner
    path.lineTo(size.width, size.height * 0.5); // Halfway down on the right
    path.lineTo(0, size.height * 0.5); // Halfway down on the left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Frame3875 extends StatefulWidget {
  @override
  State<Frame3875> createState() => _Frame3875State();
}

class _Frame3875State extends State<Frame3875>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to verify?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Perform the verification action here
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
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
            DefaultTabController(
              length: 4,
              child: Expanded(
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        child: TabBar(
                            labelColor: Colors.black,
                            labelPadding: EdgeInsets.symmetric(
                                horizontal: 8.0), // Adjust tab padding
                            labelStyle: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ), // Adjust label font size
                            indicatorSize: TabBarIndicatorSize.label,
                            tabs: [
                              Tab(text: "Personal Info"),
                              Tab(text: "Organisation"),
                              Tab(text: "Documents"),
                              Tab(text: "References"),
                            ]),
                      ),
                    ),
                    Container(
                      //Add this to give height
                      height: MediaQuery.of(context).size.height - 300,
                      child: TabBarView(children: [
                        SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: [
                                Info(label: "Full name", val: "Neesham Raghav"),
                                Info(
                                    label: "Email",
                                    val: "neeshamraghav0@gmail.com"),
                                Info(
                                  label: "Mobile number",
                                  val: "+917206126235",
                                ),
                                Info(
                                    label: "Address",
                                    val: "BPTP Resorts, Sector 75"),
                                Infocolumn(
                                  label1: "City",
                                  val1: "City name",
                                  label2: "State",
                                  val2: "Delhi",
                                ),
                                Infocolumn(
                                    label1: "Speciality",
                                    val1: "Investment deals",
                                    label2: "Total experience",
                                    val2: "10"),
                                Infocolumn(
                                    label1: "RERA Expiry Date",
                                    val1: "10-06-2025",
                                    label2: "Operating region",
                                    val2: "North"),
                              ],
                            ),
                          ),
                        ),

                        // Organization Tab
                        Container(
                          child: Column(children: [
                            Info(
                              label: "User type",
                              val: "Individual",
                            ),
                          ]),
                        ),

                        // Document tab
                        Container(
                          child: Column(children: [
                            Padding(
                              padding: EdgeInsets.only(left: 30, top: 10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Aadhar Card',
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                    height: 1.50,
                                    letterSpacing: 0.25,
                                  ),
                                ),
                              ),
                            ),
                            Info(label: "PAN Number", val: "HGTF1638HDK"),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.file_download),
                              label: Text("DOWNLOAD IMAGE"),
                              style: ElevatedButton.styleFrom(
                                primary: Color(
                                    0xFF3C3C3C), // Set the background color here
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                            ),
                          ]),
                        ),

                        // Reference tab
                        Container(
                          child: Column(children: [
                            Info(
                                label: "Reference name",
                                val: "Leslie Alexander"),
                            Info(
                                label: "Reference contact number",
                                val: "(316) 555-0116"),
                            Info(
                                label: "Reference Email",
                                val: "abc@domain.com"),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showConfirmationDialog(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30), // Adjust the value for the desired corner radius
                                    ),
                                    backgroundColor: Color(0xFF2A2A2A),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40,
                                        vertical:
                                            15), // Change the color to your desired color
                                  ),
                                  child: Text(
                                    'Verify',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white, // Text color
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ]),
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

class Infocolumn extends StatelessWidget {
  final String label1;
  final String val1;

  final String label2;
  final String val2;

  const Infocolumn({
    Key? key,
    required this.label1,
    required this.val1,
    required this.label2,
    required this.val2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 23, top: 10),
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 5, top: 5),
                      child: Text(
                        label1,
                        style: TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 10,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 1.60,
                          letterSpacing: 0.25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        val1,
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
                  ]),
              width: 170,
              height: 50,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFFDBE2EA)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 23, top: 10),
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 5, top: 5),
                      child: Text(
                        label2,
                        style: TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 10,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 1.60,
                          letterSpacing: 0.25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        val2,
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
                  ]),
              width: 170,
              height: 50,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFFDBE2EA)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class Info extends StatelessWidget {
  final String label;
  final String val;

  const Info({
    Key? key,
    required this.label,
    required this.val,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 5),
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(left: 15, bottom: 5, top: 5),
            child: Text(
              label,
              style: TextStyle(
                color: Color(0xFF757575),
                fontSize: 10,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.60,
                letterSpacing: 0.25,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              val,
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
        ]),
        width: 342,
        height: 50,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.50, color: Color(0xFFDBE2EA)),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
