import 'package:flutter/material.dart';
import 'package:hra/admin/articleblock.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:core';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';
import 'dart:math';

class ArticleDetailsPage extends StatefulWidget {
  final int articleId;

  ArticleDetailsPage({required this.articleId});

  @override
  State<ArticleDetailsPage> createState() => _Art1State();
}

class _Art1State extends State<ArticleDetailsPage> {
  final ArticleBloc articleBloc = ArticleBloc();
  bool downloading = false;


  Future<void> writeOnPdf() async {
    setState(() {
      downloading = true;
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
        "${directory?.path}/HRA_Article${DateTime.now().toString().replaceAll(" ", "-")}.pdf");
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
      downloading = false;
    });
  }

  String generateRandomName() {
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final length = 10;

    return String.fromCharCodes(
      List.generate(
          length, (index) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

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
        padding: EdgeInsets.only(top: 10.0),
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
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                        width: 341,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: Image.asset(
                          articleBloc.articleList[widget.articleId]
                              .img, // Provide the URL of the image
                          width: 341, // Adjust the width as needed
                          height: 200, // Adjust the height as needed
                          fit: BoxFit
                              .cover, // Choose the appropriate fit for your image
                        )),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Place items at start and end of the row
                    children: [
                      Text(
                        articleBloc.articleList[widget.articleId].title,
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff14303c),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      downloading
                          ? CircularProgressIndicator()
                          : IconButton(
                              onPressed: () {
                                writeOnPdf();

                                var snackdemo = SnackBar(
                                  content: Text("Article downloaded!"),
                                  backgroundColor: Colors.green,
                                  elevation: 10,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(5),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackdemo);
                              },
                              icon: Icon(Icons.download),
                            ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: SingleChildScrollView(
                      child: Text(
                        articleBloc.articleList[widget.articleId].description,
                        style: const TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000),
                        ),
                        textAlign: TextAlign.left,
                        maxLines:
                            1000, // Adjust the number of visible lines as needed
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
