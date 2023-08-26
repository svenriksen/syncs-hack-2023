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

  void alreadyLoggedInCheck() {
    var isInfoSaved = UserPreferences.getUsername() != '' ? true : false;
    debugPrint(isInfoSaved.toString()); 
    if (isInfoSaved == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        elevation: 5,
      ),
      body: Column(children: [
        ElevatedButton(
            onPressed: () async {
              try {
                dynamic result = await _googleSignIn.signIn();
                
                if (result != null) {
                  await UserPreferences.setUsername(result.displayName);
                  await UserPreferences.setId(result.id);
                  await UserPreferences.setPhotoUrl(result.photoUrl);

                  if (!context.mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(url: result),
                    ),
                  );
                }
              } catch (error) {
                debugPrint(error.toString());
              }
            },
            child: const Text("Sign in with Google"))
      ]),
    );
  }
}
