import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in/widgets.dart';
// import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  Home({super.key, required this.url});
  GoogleSignInAccount url;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late GoogleIdentity avatar = widget.url;
  @override
  void initState() {
    avatar = widget.url;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Home"),
          elevation: 5,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GoogleUserCircleAvatar(identity: avatar),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your book choices",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Return to your past read books :)",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CarouselSlider(
                    items: [1, 2, 3]
                        .map((e) => Builder(builder: (BuildContext context) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                child: Center(
                                  child: Text(
                                    'text $e',
                                    style: const TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                  ),
                                ),
                              );
                            }))
                        .toList(),
                    options: CarouselOptions(height: 400, autoPlay: false)),
              ),
            ],
          ),
        ));
  }
}
