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
                debugPrint(result.toString());
                if (result != null) {
                  if (!context.mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
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
