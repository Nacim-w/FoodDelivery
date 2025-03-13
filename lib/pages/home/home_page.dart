import 'package:flutter/material.dart';
import 'package:testing/pages/home/widgets/home_page_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<Map<String, String>> categories = const [
  {'name': 'Pizza', 'image': 'assets/images/Categories.png'},
  {'name': 'Pan-cake', 'image': 'assets/images/Categories.png'},
  {'name': 'Sandwich', 'image': 'assets/images/Categories.png'},
  {'name': 'Ice-cream', 'image': 'assets/images/Categories.png'},
];

List<Widget> stories = [
  Stack(
    children: [
      buildStory("alex", "assets/images/story2.png"),
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
  buildStory("james", "assets/images/story3.png"),
  buildStory("mohamed", "assets/images/story4.png"),
  buildStory("nacim", "assets/images/story.png"),
  buildStory("test", "assets/images/story2.png"),
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

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Color(0xFFFFFCFC),
      body: SingleChildScrollView(
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
                  buildCategory(categories),
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
                          child: buildFeatured(
                              item["name"], item["image"], item["price"]),
                        );
                      },
                    ),
                  ),
                  BuildCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
