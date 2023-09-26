import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
class CertificatePage extends StatefulWidget {
  @override
  State<CertificatePage> createState() => _CertificateState();
}

class _CertificateState extends State<CertificatePage> {
  Map<String, bool> downloading = {"IdCard":false, "MembershipCertificate":false};
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
        "${directory?.path}/HRA_${index}${DateTime.now().toString().replaceAll(" ", "-")}.pdf");
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Certificate",
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
          //mainAxisAlignment: MainAxisAlignment.center,
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
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      width: width*0.85,
                      height: height*0.07,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color.fromRGBO(245, 251, 252, 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'images/ii.jpg', // Replace with the path to your image
                              width: 26, // Adjust the width as needed
                              height: 22, // Adjust the height as needed
                            ),
                            SizedBox(width: 20),
                            Text(
                              "View ID CARD",
                              style: const TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                height: 24 / 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 152),
                            GestureDetector(
                              onTap: () {
                                // Add your download functionality here
                                writeOnPdf("IdCard");
                              },
                              child: downloading["IdCard"]==false?Image.asset(
                                  'images/download.jpg'):CircularProgressIndicator(), // Replace with your image asset path
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Add more widgets as needed
              ],
            ),

            //SizedBox(height: 5), // Add spacing between the image and the column
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Container(
                      width: width*0.85,
                      height: height*0.07,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color.fromRGBO(245, 251, 252, 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'images/ii.jpg', // Replace with the path to your image
                              width: 26, // Adjust the width as needed
                              height: 22, // Adjust the height as needed
                            ),
                            SizedBox(width: 20),
                            Text(
                              "View Membership Certificate",
                              style: const TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                height: 24 / 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 58),
                            GestureDetector(
                              onTap: () {
                                // Add your download functionality here
                                writeOnPdf("MembershipCertificate");
                              },
                              child: downloading["MembershipCertificate"]==false?Image.asset(
                                  'images/download.jpg'):CircularProgressIndicator(), // Replace with your image asset path
                            ),
                          ],
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
