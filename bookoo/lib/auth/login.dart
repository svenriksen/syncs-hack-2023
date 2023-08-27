import 'package:bookoo/auth/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../pages/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  @override
  void initState() {
    alreadyLoggedInCheck();
    super.initState();
  }

  void alreadyLoggedInCheck() async {
    var isInfoSaved = UserPreferences.getUsername() != '' ? true : false;

    if (isInfoSaved == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.1), BlendMode.srcOver),
            image: AssetImage("assets/main background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 2 + 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          dynamic result = await _googleSignIn.signIn();

                          if (result != null) {
                            await UserPreferences.setUsername(
                                result.displayName);
                            await UserPreferences.setId(result.id);
                            await UserPreferences.setPhotoUrl(result.photoUrl);

                            if (!context.mounted) return;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ),
                            );
                          }
                        } catch (error) {
                          debugPrint(error.toString());
                        }
                      },
                      child: const Text("Sign in with Google"))
                ]),
          ),
        ),
      ),
    );
  }
}
