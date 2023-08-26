import 'package:bookoo/pages/components/appbar.dart';
import 'package:bookoo/pages/read.dart';
import 'package:flutter/material.dart';
import '../auth/user_preference.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class AllBooks extends StatefulWidget {
  const AllBooks({super.key});

  @override
  State<AllBooks> createState() => _AllBooksState();
}

Future<File> _writeFileByte(String? file) async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  PdfDocument document = PdfDocument.fromBase64String(file!);

  List<int> bytes = await document.save();
  File('$dir/output.pdf').writeAsBytes(bytes!);
  return File('$dir/output.pdf');
}

class _AllBooksState extends State<AllBooks> {
  List<String> entries = UserPreferences.getUploadedBooks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (BuildContext context, index) {
                late File file;
                _writeFileByte(entries[index]).then((value) {
                  file = value;
                });
                //use container to create a box
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReadBook()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SizedBox(
                      height: 120,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                width: double.infinity,
                                height: 120,
                              )),
                          Flexible(
                            flex: 9,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 7, 0, 7),
                              child: SizedBox(
                                height: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "This is the title $index",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text("This is the author",
                                        style: TextStyle(fontSize: 14)),
                                    const Spacer(),
                                    const Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text("thisisafile.pdf"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
