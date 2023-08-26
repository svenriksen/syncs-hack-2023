import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class FindBook extends StatefulWidget {
  const FindBook({super.key});

  @override
  State<FindBook> createState() => _FindBookState();
}

class _FindBookState extends State<FindBook> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    decoration: const InputDecoration(
                      hintText:
                          "Using your imagination, describe the book you want to read",
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    maxLines: 7,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please let us know what are you looking for!';
                      }
                      return null;
                    },
                    controller: myController),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: OutlinedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            var inputText = myController.text;
                            debugPrint(inputText);

                            final response = await http.post(
                                Uri.parse(
                                    'http://syncs-hack-2023.vercel.app:3000/recommend'),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                                body: jsonEncode(<String, dynamic>{
                                  "accID": "123",
                                  "prompt": inputText,
                                  "past_books": ""
                                }));
                            debugPrint(response.body);
                          }
                        },
                        child: const Text("Find")),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
