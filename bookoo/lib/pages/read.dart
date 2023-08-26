import 'package:bookoo/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../auth/user_preference.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ReadBook extends StatefulWidget {
  ReadBook({super.key, required this.base64});
  String base64;
  @override
  State<ReadBook> createState() => _ReadBookState();
}

Future<File> _writeFileByte(String? file) async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  PdfDocument document = PdfDocument.fromBase64String(file!);
  print(file);
  List<int> bytes = await document.save();
  File('$dir/output.pdf').writeAsBytes(bytes!);
  return File('$dir/output.pdf');
}

class _ReadBookState extends State<ReadBook> {
  late String file;
  late List<String> books;
  List<int>? bytes;
  late PdfDocument document;
  late String dir;
  @override
  void initState() {
    books = UserPreferences.getUploadedBooks();

    file = widget.base64;
    // print(file);
    // bytes = base64Decode(file!);

    UserPreferences.setRecentlyRead(file);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color filtercolor = Colors.red;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Read Book"),
        elevation: 5,
        actions: [
          PopupMenuButton<String>(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10)
              )
            ),
            onSelected: (String value){
              if (value == 'nine') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              if(value == 'ten'){
                
              }
              if(value == 'eleven'){
                filtercolor = Colors.blue;
              }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'nine',
                child: Text("MonteNete"),
                
              ),
              const PopupMenuItem(
                value: 'ten',
                child: Text("Change Music"),
                
              ),
              const PopupMenuItem(
                value: 'eleve',
                child: Text("Eye Care"),
                
              )
            
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
        child: (file != null)
            ? FutureBuilder(
                future: _writeFileByte(file),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SfPdfViewer.file(
                      snapshot.data as File,
                      initialZoomLevel: 1,
                      scrollDirection: PdfScrollDirection.vertical,
                      onZoomLevelChanged: (PdfZoomDetails details) {
                        print(details.newZoomLevel);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error ${snapshot.error}'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })
            : const Center(child: Text("No book found")),
      ),
    );
    
    
  }
}
