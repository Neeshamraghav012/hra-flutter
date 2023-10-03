import 'package:flutter/material.dart';
import 'package:hra/admin/articledetails.dart';
import 'package:hra/admin/articleblock.dart';

class ArticleCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String date;
  final VoidCallback onPressed;

  ArticleCard({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.date,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 163,
      height: 200,
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
      child: GestureDetector(
        onTap: onPressed, // Trigger the callback when the card is tapped
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(10.0),
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(10.0),
                //   topRight: Radius.circular(10.0),
                // ),
                child: GestureDetector(
                  onTap:
                      onPressed, // Trigger the callback when the image is tapped
                  child: Image.network(
                    imagePath,
                    width: 163,
                    height: 95,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 2, top: 2, bottom: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff14303c),
//height: 32/11,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      description,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 7,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff3c4042),
//height: 32/7,
                      ),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow
                          .ellipsis, // Handle overflow with ellipsis
                      maxLines: 3,
                    ),
                    SizedBox(height: 4.0), // Add some space
                    Text(
                      date, // Display the date here
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 7,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 160, 155, 155),
                        // height: 24 / 7,
                      ),
                      textAlign: TextAlign.right,
                    ),
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

class ArticlesPage extends StatefulWidget {
  @override
  State<ArticlesPage> createState() => _ArtState();
}

class _ArtState extends State<ArticlesPage> {
  final ArticleBloc articleBloc = ArticleBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        backgroundColor: Colors.white,
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
      backgroundColor: Colors.white,
      body: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 16.0, left: 8, right: 8),
          //  child: Column(
          // children: [
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
        // ],
        // ),
        SizedBox(height: 12),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 cards in a row
              childAspectRatio:
                  0.8, // You can adjust the aspect ratio as needed
            ),
            itemCount: articleBloc.articleList.length,
            itemBuilder: (context, index) {
              Article article = articleBloc.articleList[index];
              return ArticleCard(
                imagePath: article.bannerImg,
                title: article.title,
                description: article.description,
                date: article.date, // Use the date from your event data
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ArticleDetailsPage(articleId: index),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
