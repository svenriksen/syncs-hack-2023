import 'dart:convert';

import 'package:bookoo/pages/components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:async';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  FilePickerResult? result;
  late bool isFilePicked;
  @override
  void initState() {
    isFilePicked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Add your book here",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Your book will be added to the local storage as we respect your privacy",
              style: TextStyle(fontSize: 15),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Form(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 60 / 100,
                    child: OutlinedButton(
                        onPressed: () async {
                          result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf', 'epub'],
                          );
                          if (result != null) {
                            setState(() {
                              isFilePicked = true;
                            });
                          } else {
                            setState(() {
                              isFilePicked = false;
                            });
                          }
                        },
                        child: const Text("Upload file (.pdf)")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 60 / 100,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                        ),
                        onPressed: (result != null
                            ? () {
                                File file = File(result!.files.single.path!);

                                final bytes = file.readAsBytesSync();
                                String fileInString = base64Encode(bytes);
                                debugPrint(fileInString);
                              }
                            : null),
                        child: const Text("Submit")),
                  ),
                )
              ],
            )),
          )
        ]),
      ),
    );
  }
}
