import 'dart:convert';
import 'dart:typed_data';

import 'package:bookoo/auth/user_preference.dart';
import 'package:bookoo/pages/read.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:thumbnailer/thumbnailer.dart';
import 'allbooks.dart';
import 'home.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

Future<String> getJson() async {
  dynamic response = http.get(Uri.parse(
      "http://api.nytimes.com/svc/books/v3/lists/overview.json?api-key=bxw9TZLsBWkQEd0R2DtIv8uIBP0XKr5B"));
  return response.body;
}

class _FirstPageState extends State<FirstPage> {
  late String recently;
  late dynamic tmp;

  late dynamic books;
  dynamic tmpp;
  @override
  void initState() {
    recently = UserPreferences.getRecentlyRead();
    http
        .get(Uri.parse(
            "http://api.nytimes.com/svc/books/v3/lists/overview.json?api-key=bxw9TZLsBWkQEd0R2DtIv8uIBP0XKr5B"))
        .then((value) {
      books = jsonDecode(value.body);

      tmpp = books["results"]["lists"][0]["books"];
      setState(() {
        tmpp = books["results"]["lists"][0]["books"];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Your book choices",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const Text(
          "Review your book choices here",
          style: TextStyle(fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: CarouselSlider(
              items: tmpp
                  .map<Widget>((e) => Builder(builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () async {
                            try {
                              await launchUrl(e["amazon_product_url"]);
                            } catch (error) {}
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 50 / 100,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.5),
                                      BlendMode.srcOver),
                                  image: NetworkImage(e["book_image"]),
                                  fit: BoxFit.cover),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  e["title"],
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      }))
                  .toList(),
              options: CarouselOptions(
                disableCenter: true,
                enlargeCenterPage: false,
                height: 300,
                autoPlay: false,
                viewportFraction: 0.5,
              )),
        ),
        const Text(
          "Resume your journey",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: (recently != null && recently != ''
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReadBook(base64: recently)),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          width: double.infinity,
                          height: 200,
                          child: Thumbnail(
                              dataResolver: () async {
                                Uint8List bytes = base64Decode(recently);
                                return bytes;
                              },
                              mimeType: 'application/pdf',
                              widgetSize: 300),
                        ),
                      ),
                      Flexible(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "This is the title",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("This is the author",
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: IgnorePointer(
                                  child: RatingBar.builder(
                                    initialRating: 3.5,
                                    allowHalfRating: true,
                                    itemSize: 20,
                                    itemBuilder: ((context, index) {
                                      return const Icon(
                                        Icons.star,
                                        color: Colors.black,
                                      );
                                    }),
                                    onRatingUpdate: (rating) {
                                      debugPrint(rating.toString());
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : null),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: OutlinedButton(
              onPressed: () {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(
                              index: 1,
                            )),
                  );
                });
              },
              child: const Row(
                children: [
                  Icon(Icons.search),
                  Text("Search for the book you want")
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AllBooks()),
                );
              },
              child: const Text("See all saved books")),
        ),
      ],
    );
  }
}
