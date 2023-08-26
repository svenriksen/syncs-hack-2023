import 'package:flutter/material.dart';

class FindBook extends StatefulWidget {
  const FindBook({super.key});

  @override
  State<FindBook> createState() => _FindBookState();
}

class _FindBookState extends State<FindBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
        child: Form(
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () {}, child: const Text("Find"))),
            )
          ],
        )),
      ),
    );
  }
}
