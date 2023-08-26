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

  List<int> entries = [1, 2, 3, 4, 5, 6, 7];

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
      body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (BuildContext context, index) {
                //use container to create a box
                return Padding(
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
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
                );
              })),
    );
  }
}
