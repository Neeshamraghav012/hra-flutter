import 'package:flutter/material.dart';
import 'package:hra/admin/Aricles-details.dart';
import 'package:hra/admin/Events-details.dart';
import 'package:hra/admin/articleblock.dart';
import 'package:hra/admin/eventblock.dart';

class EventCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String date;
  final VoidCallback onPressed;

  EventCard({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.date,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onPressed, // Trigger the callback when the card is tapped
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: GestureDetector(
                  onTap:
                      onPressed, // Trigger the callback when the image is tapped
                  child: Image.network(
                    imagePath,
                    width: double.infinity,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    // Text(
                    //   subTitle,
                    //   style: TextStyle(
                    //     fontSize: 14.0,
                    //     color: Colors.grey,
                    //   ),
                    // ),
                    // SizedBox(height: 8.0), // Add some space
                    // Text(
                    //   date, // Display the date here
                    //   style: TextStyle(
                    //     fontSize: 14.0,
                    //     color: Colors.grey,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArtPage extends StatefulWidget {
  @override
  State<ArtPage> createState() => _ArtState();
}

class _ArtState extends State<ArtPage> {
  final ArticleBloc articleBloc = ArticleBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Articles",
          style: const TextStyle(
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
        child: ListView.builder(
          itemCount: articleBloc.articleList.length,
          itemBuilder: (context, index) {
            Article article = articleBloc.articleList[index];
            return EventCard(
              imagePath: article.bannerImg,
              title: article.title,
              description: article.description,
              date: article.date, // Use the date from your event data
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArtPage1(articleId: index),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
