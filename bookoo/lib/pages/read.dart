import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../auth/user_preference.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ReadBook extends StatefulWidget {
  const ReadBook({super.key});

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
  String? file;
  late List<String> books;
  List<int>? bytes;
  late PdfDocument document;
  late String dir;
  @override
  void initState() {
    books = UserPreferences.getUploadedBooks();

    file = books[books.length - 1];
    print(books.length);
    print(file);
    // bytes = base64Decode(file!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Read Book"),
        elevation: 5,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
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
