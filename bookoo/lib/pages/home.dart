import 'package:bookoo/auth/user_preference.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import '../auth/login.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  late dynamic tmp;
  
  @override
  void initState() {
    tmp = UserPreferences.getUsername();
    debugPrint(tmp.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        elevation: 5,
      ),
      body: Column(
        children: [
          Text(tmp),
          ElevatedButton(
              onPressed: () {
                UserPreferences.removePreferences();
                if (!context.mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              }, 
              child: const Text('Sign out!'), 
            ),
        ],
      ),
    );
  }
}
