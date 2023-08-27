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

  final _formKey = GlobalKey<FormState>();

  final myController = TextEditingController();

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
                borderRadius: BorderRadius.all(Radius.circular(10))),
            onSelected: (String value) {
              if (value == 'nine') {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text("Pomodoro"),
                          content: Stack(children: [
                            const Text("Set your timer here"),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    controller: myController,
                                    decoration: const InputDecoration(
                                      hintText:
                                          "Enter your time here (format MM:SS))",
                                      border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                    ),
                                    maxLines: 1,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your time';
                                      }
                                      var minutes =
                                          int.parse(value.split(':')[0]);
                                      var seconds =
                                          int.parse(value.split(':')[1]);
                                      if (minutes < 0 || seconds < 0) {
                                        // raise error "minutes or seconds < 0"
                                        return 'minutes or seconds < 0';
                                      }
                                      if (seconds >= 60) {
                                        return "seconds needs to be between 0 and 59 (inclusive)";
                                      }
                                      return null;
                                    },
                                  )),
                            )
                          ]),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    var inputText = myController.text;
                                  }
                                  Navigator.pop(context);
                                },
                                child: const Text("Start"))
                          ],
                        ));
                if (value == 'ten') {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text("Choose music settings"),
                            content: const Stack(children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                              )
                            ]),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Start"))
                            ],
                          ));
                }
                if (value == 'eleven') {}
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'nine',
                child: Text("Pomodoro"),
              ),
              const PopupMenuItem(
                value: 'ten',
                child: Text("Music Settings"),
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        child: (file != null)
            ? FutureBuilder(
                future: _writeFileByte(file),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SfPdfViewer.file(
                      snapshot.data as File,
                      initialZoomLevel: 1,
                      scrollDirection: PdfScrollDirection.vertical,
                      onZoomLevelChanged: (PdfZoomDetails details) {},
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
