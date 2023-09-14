import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<DiscoverPage> {
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discover people',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 75,
        automaticallyImplyLeading: false,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60), // Adjust the radius as needed
            bottomRight: Radius.circular(56), // Adjust the radius as needed
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13, left: 4, right: 17),
            child: Container(
              width: 369,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(10), // Adjust the radius as needed
                border: Border.all(),
              ),
              child: TextField(
                decoration: InputDecoration(
                  //hintText: 'Search',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 14, left: 5, right: 17),
              child: Container(
                padding:
                    EdgeInsets.only(top: 9, left: 11, right: 11, bottom: 9),
                width: 369,
                height: 66,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.50, color: Color(0xFFE6EBF0)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/icon.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 13),
                          child: Column(
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: "Emiley Jackson\n",
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "1,245 followers",
                                      style: const TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff000000),
                                        //height: 20 / 14,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        )
                      ]),
                      //Expanded(
                      //SizedBox(width: 70),
                      Container(
                        width: 84,
                        height: 28,
                        child: Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  clicked = true;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: clicked ? Colors.grey :
                                 Colors.red,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 1,
                                  vertical: 5,
                                ),
                              ),
                              child: Text(
                               clicked ? "Following" : "Follow +",
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  //height: 21/14,
                                ),
                                textAlign: TextAlign.left,
                              )),
                        ),
                      ),
                      // ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
