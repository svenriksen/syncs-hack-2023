import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AllBooks extends StatefulWidget {
  AllBooks({super.key, this.url});
  late GoogleSignInAccount? url;

  @override
  State<AllBooks> createState() => _AllBooksState();
}

class _AllBooksState extends State<AllBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Books"),
        elevation: 5,
      ),
      body: const Placeholder(),
    );
  }
}
