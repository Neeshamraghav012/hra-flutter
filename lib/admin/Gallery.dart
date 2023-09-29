import 'package:flutter/material.dart';
import 'package:hra/admin/gallary-image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GalleryPage extends StatefulWidget {
  @override
  State<GalleryPage> createState() => _GalleryState();
}

List<String> imgs = [
  'G1',
  'G2',
  'E1',
  'E2',
  'E3',
  'E4',
  'G3',
  'G1',
  'G2',
  'E1',
  'E2',
  'E3',
  'E4',
  'G3',
  'G2'
];

class _GalleryState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Gallery",
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
         /* Container(
            margin: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/pp.jpg'),
              radius: 20,
            ),
          ),*/
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
                    image: AssetImage('images/ad.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.all(8.0), // Adjust the padding values as needed
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 columns
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                  ),
                  itemCount: imgs
                      .length, // Assuming you have 15 images in your gallery
                  itemBuilder: (context, index) {
                    // Replace 'images/image_$index.jpg' with your actual image paths
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GalleryImagePage(image: imgs[index],)),
                          
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          //borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('images/' + imgs[index] + '.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Column(
              children: [
                Center(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                    child: Container(
                      width: 342,
                      height: 68, // Adjust the height as needed
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage('images/ad.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
