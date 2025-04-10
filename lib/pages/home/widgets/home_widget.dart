import 'package:flutter/material.dart';
import 'package:testing/pages/home/widgets/home_category_widget.dart';
import 'package:testing/pages/home/widgets/home_page_widgets.dart';
import 'package:testing/pages/home/widgets/home_recommanded_widget.dart';
import 'package:testing/pages/home/widgets/home_story_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: stories,
            ),
          ),
          Image(
            image: AssetImage("assets/images/hero.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Top Categories',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See all',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                HomeCategory(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'La Plus Rapide',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See all',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: featuredItems.length,
                    itemBuilder: (context, index) {
                      final item = featuredItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: HomeRecommanded(
                            image: item["image"],
                            text: item["name"],
                            price: item["price"]),
                      );
                    },
                  ),
                ),
                buildCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> stories = [
  Stack(
    children: [
      HomeStory(username: "alex", image: "assets/images/story2.png"),
      Positioned(
        bottom: 0,
        left: 10,
        top: 0,
        child: Image(
          image: AssetImage("assets/icons/plus.png"),
        ),
      ),
    ],
  ),
  HomeStory(username: "james", image: "assets/images/story3.png"),
  HomeStory(username: "mohamed", image: "assets/images/story4.png"),
  HomeStory(username: "nacim", image: "assets/images/story.png"),
  HomeStory(username: "test", image: "assets/images/story2.png"),
];

List<Map<String, dynamic>> featuredItems = [
  {
    "name": "Prawn mix salad",
    "image": "assets/images/featured2.png",
    "price": 5.98,
  },
  {
    "name": "Prawn mix salad",
    "image": "assets/images/featured.png",
    "price": 5.98,
  },
  {
    "name": "Prawn mix salad",
    "image": "assets/images/featured.png",
    "price": 5.98,
  },
];
