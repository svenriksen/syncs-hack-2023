import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'allbooks.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
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
          "Return to your past read books :)",
          style: TextStyle(fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: CarouselSlider(
              items: [1, 1, 2, 3]
                  .map((e) => Builder(builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 50 / 100,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
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
              options: CarouselOptions(
                disableCenter: true,
                enlargeCenterPage: false,
                height: 300,
                autoPlay: false,
                viewportFraction: 0.5,
              )),
        ),
        const Text(
          "Reading now",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    width: double.infinity,
                    height: 200,
                  )),
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
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text("This is the author",
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
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
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllBooks()),
                );
              },
              child: const Text("See all")),
        ),
      ],
    );
  }
}
