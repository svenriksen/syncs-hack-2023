import 'package:bookoo/auth/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter/widgets.dart';
import '../auth/login.dart';

import 'firstpage.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class CustomGoogleIdentity implements GoogleIdentity {
  CustomGoogleIdentity(this.data) {
    pdisplayName = data["Displayname"]!;
    pemail = "";
    pid = data["ID"]!;
    pphotoUrl = data["URL"]!;
  }

  Map<String, String> data;
  String pdisplayName = "";

  String pemail = "";

  String pid = "";

  String pphotoUrl = "";
  @override
  String get id => pid;

  @override
  String get email => pemail;

  @override
  String? get displayName => pdisplayName;

  @override
  String? get photoUrl => pphotoUrl;

  @override
  String? get serverAuthCode => "";
}

class _HomeState extends State<Home> {
  CustomGoogleIdentity userAccount = CustomGoogleIdentity({
    "Displayname": UserPreferences.getUsername(),
    "ID": UserPreferences.getId(),
    "URL": UserPreferences.getPhotoUrl()
  });

  int pageIndex = 0;
  @override
  void initState() {
    UserPreferences.getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            debugPrint(value.toString());
            pageIndex = value;
          });
        },
        selectedIndex: pageIndex,
        destinations: const [
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: "Home"),
          NavigationDestination(
              selectedIcon: Icon(Icons.search_off_outlined),
              icon: Icon(Icons.search_outlined),
              label: "Find Book"),
        ],
      ),
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Home"),
        elevation: 5,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GoogleUserCircleAvatar(identity: userAccount),
          )
        ],
      ),
      body: <Widget>[
        const SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(15, 50, 15, 0), child: FirstPage()),
        ),
        const Text("Find Book"),
      ][pageIndex],
    );
  }
}
