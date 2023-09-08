import 'package:flutter/material.dart';

class EventPage1 extends StatefulWidget {
  @override
  State<EventPage1> createState() => _Event1State();
}

class _Event1State extends State<EventPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Articles",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            height: 24 / 16,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/pp.jpg'),
              radius: 20,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 342,
                height: 68,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage('images/adssss.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EventCard(
                    imagePath: 'images/E1.jpg',
                    title: "CP Event",
                    subTitle: "Just for PROH Members",
                    buttonLabel: 'View Details',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  EventCard(
                    imagePath: 'images/E2.jpg',
                    title: "CP Event",
                    subTitle: "Just for PROH Members",
                    buttonLabel: 'View Details',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EventCard(
                    imagePath: 'images/E3.jpg',
                    title: "CP Event 2",
                    subTitle: "Just for HRA Members",
                    buttonLabel: 'View Details',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  EventCard(
                    imagePath: 'images/E4.jpg',
                    title: "CP Event name",
                    subTitle: "Just for HRA Members",
                    buttonLabel: 'View Details',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subTitle;
  final String buttonLabel;
  final VoidCallback onPressed;

  EventCard({
    required this.imagePath,
    required this.title,
    required this.subTitle,
    this.buttonLabel = '',
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 164,
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            width: 164,
            height: 133,
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 5),
          Text(
            subTitle,
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Color(0xff3c4042),
            ),
            textAlign: TextAlign.left,
          ),
          if (buttonLabel.isNotEmpty) SizedBox(height: 5),
          Container(
            width: 110,
            height: 30,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
              child: Text(buttonLabel),
            ),
          ),
        ],
      ),
    );
  }
}
