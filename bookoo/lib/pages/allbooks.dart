import 'package:flutter/material.dart';
import 'home.dart';
import '../auth/user_preference.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AllBooks extends StatefulWidget {
  const AllBooks({super.key});

  @override
  State<AllBooks> createState() => _AllBooksState();
}

class _AllBooksState extends State<AllBooks> {
  CustomGoogleIdentity userAccount = CustomGoogleIdentity({
    "Displayname": UserPreferences.getUsername(),
    "ID": UserPreferences.getId(),
    "URL": UserPreferences.getPhotoUrl()
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("All saved books"),
        elevation: 5,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GoogleUserCircleAvatar(identity: userAccount),
          )
        ],
      ),
      body: const Placeholder(),
    );
  }
}
