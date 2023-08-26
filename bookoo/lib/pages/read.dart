import 'package:flutter/material.dart';

class ReadBook extends StatefulWidget {
  const ReadBook({super.key});

  @override
  State<ReadBook> createState() => _ReadBookState();
}

class _ReadBookState extends State<ReadBook> {
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
      body: const Placeholder(),
    );
  }
}
