import 'package:flutter/material.dart';
import 'package:hra/admin/eventdetails.dart';
import 'package:hra/admin/eventblock.dart';

class EventListPage extends StatefulWidget {
  @override
  State<EventListPage> createState() => _EventListState();
}

class _EventListState extends State<EventListPage> {
  final EventBlock eventBlock = EventBlock();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Events",
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
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          /*Container(
            margin: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/pp.jpg'),
              radius: 20,
            ),
          ),*/
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(2),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.0, left: 8, right: 8),
              // Use ListView.builder to build the EventCard widgets
              child: Center(
                child: Container(
                  height: 68,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage(
                          'images/adssss.jpg'), // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 cards in a row
                  childAspectRatio:
                      0.8, // You can adjust the aspect ratio as needed
                ),
                itemCount: eventBlock.eventList.length,
                itemBuilder: (context, index) {
                  Event event = eventBlock.eventList[index];
                  return EventCard(
                    imagePath:
                        event.bannerImg, // You can use the bannerImg here
                    title: event.title,
                    subTitle: event.subtitle,
                    buttonLabel: 'View Details',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventDetailsPage(
                                  eventId: index,
                                )),
                      );
                    },
                  );
                },
              ),
            ),
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
    return
        // Add padding around the container
        Container(
      width: 164,
      // height: 233,
      margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.black, // Specify the border color here
      //     width: 1.0, // Specify the border width here
      //   ),
      // ),
      // Trigger the callback when the card is tapped
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(10.0),
            ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Container(
          // width: 164,
          // height: 133,
          ClipRRect(
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 6),
          Container(
            padding: EdgeInsets.only(
                left: 5.0), // Add left padding to the text and button container
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                SizedBox(height: 4),
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
                if (buttonLabel.isNotEmpty) SizedBox(height: 6),
                Container(
                  width: 145,
                  height: 28, // Adjust width as needed
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the radius as needed
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4), // Adjust vertical padding as needed
                      child: Text(buttonLabel),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
