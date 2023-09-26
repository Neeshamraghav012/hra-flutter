import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class BrochurePage extends StatefulWidget {
  @override
  State<BrochurePage> createState() => _BroState();
}

class _BroState extends State<BrochurePage> {
  List<bool> downloading = List.generate(5, (index) => false);

  Future<void> writeOnPdf(index) async {
    setState(() {
      downloading[index] = true;
    });
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: <pw.Widget>[
                    pw.Text('Geeksforgeeks', textScaleFactor: 2),
                  ])),
          pw.Header(level: 1, text: 'What is Lorem Ipsum?'),
          pw.Paragraph(
              text:
              '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
                  tempor incididunt ut labore et dolore magna aliqua. Nunc mi ipsum faucibus
                  vitae aliquet nec. Nibh cras pulvinar mattis nunc sed blandit libero
                  volutpat Vitae elementum curabitur vitae nunc sed velit. Nibh tellus
                  molestie nunc non blandit massa. Bibendum enim facilisis gravida neque.
                  Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Enim diam
                  vulputate ut pharetra sit. Tellus pellentesque eu tincidunt tortor
                  aliquam nulla facilisi cras fermentum. ''',
              style: pw.TextStyle(font: pw.Font.symbol())),
          pw.Header(level: 1, text: 'This is Header'),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
          pw.Table.fromTextArray(
            context: context,
            data: const <List<String>>[
              <String>['Year', 'Sample'],
              <String>['SN0', 'GFG1'],
              <String>['SN1', 'GFG2'],
              <String>['SN2', 'GFG3'],
              <String>['SN3', 'GFG4'],
            ],
          ),
        ];
      },
    ));


    final directory = await getExternalStorageDirectory();

    final file = File(
        "${directory?.path}/HRA_Brochure${DateTime.now().toString().replaceAll(" ", "-")}.pdf");
    if (await Permission.storage.request().isGranted) {
      await file.writeAsBytes(await pdf.save());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Article saved Successfully in ${file.path}"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Permissione denied"),
      ));
    }

    setState(() {
      downloading[index] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Brochures",
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
            margin: EdgeInsets.all(8.0), // Adjust margin as needed
            child: CircleAvatar(
              backgroundImage: AssetImage('images/pp.jpg'),
              radius: 20, // Adjust the radius to control the size of the circle
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16.0), // Adjust the top padding as needed
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 342,
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

            SizedBox(height: 5), // Add spacing between the image and the column
            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index){
                return Column(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, top: 16, bottom: 4),
                            child: Container(
                              width: 370,
                              height: 55,
                              // child: Padding(
                              //   padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Add your download functionality here
                                      writeOnPdf(index);
                                    },
                                    child: Container(
                                      width: 50, // Increase the width
                                      height: 50, // Increase the height
                                      child: downloading[index] == false?Image.asset(
                                        'images/dow.jpg',
                                        fit: BoxFit
                                            .cover, // You can use BoxFit to control how the image fits within the container
                                      ):CircularProgressIndicator(),
                                    ), // Replace with your image asset path
                                  ),
                                  SizedBox(width: 20),
                                  Flexible(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Brochure name\n\n",
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                            "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo con",
                                            style: const TextStyle(
                                              fontSize:
                                              9, // Change the font size for the remaining text
                                              fontWeight: FontWeight
                                                  .w400, // Use a different font weight if needed
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 340, // Adjust the width of the divider as needed
                      child: Divider(
                        color: Color.fromARGB(255, 156, 151, 151),
                        thickness: 0.0,
                      ),
                    ),
                  ],
                );
              }),
            ),
            Column(
              children: [
                Center(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 160, bottom: 4),
                    child: Container(
                      width: 342,
                      height: 68, // Adjust the height as needed
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage('images/ad1.jpg'),
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
