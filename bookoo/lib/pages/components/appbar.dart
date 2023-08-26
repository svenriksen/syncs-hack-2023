import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../auth/user_preference.dart';
import '../../auth/login.dart';
import '../add.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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

class _CustomAppBarState extends State<CustomAppBar> {
  CustomGoogleIdentity userAccount = CustomGoogleIdentity({
    "Displayname": UserPreferences.getUsername(),
    "ID": UserPreferences.getId(),
    "URL": UserPreferences.getPhotoUrl()
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text("Hi, ${userAccount.displayName}"),
      elevation: 5,
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Add(),
                    ),
                  );
                },
                icon: const Icon(Icons.add))),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Spacer(),
                            SizedBox(
                                height: 100,
                                width: 100,
                                child: GoogleUserCircleAvatar(
                                    identity: userAccount)),
                            const Spacer(),
                            Text(userAccount.displayName!,
                                style: Theme.of(context).textTheme.titleSmall),
                            const Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              onPressed: () {
                                UserPreferences.removePreferences();
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Login(),
                                  ),
                                );
                              },
                              child: const Text("Logout"),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: GoogleUserCircleAvatar(identity: userAccount)),
        )
      ],
    );
  }
}
