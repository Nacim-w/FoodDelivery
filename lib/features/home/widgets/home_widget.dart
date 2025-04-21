import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/widgets/home_appbar.dart';
import 'package:legy/features/home/widgets/home_caroussel_widget.dart';
import 'package:legy/features/home/widgets/home_category_widget.dart';
//import 'package:legy/features/home/widgets/home_recommanded_widget.dart';
import 'package:legy/features/home/widgets/home_restaurants_widget.dart';
import 'package:legy/features/home/widgets/home_story_widget.dart';

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
          CustomRow(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.12,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: stories,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Offres spéciales",
                    style: TextStyles.textSemiBoldLarge.black3),
                TextButton(
                  onPressed: () {},
                  child: Text("Tout voir",
                      style: TextStyles.textSemiBoldSmall.yellow5),
                ),
              ],
            ),
          ),
          HomeCaroussal(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Catégories',
                      style: TextStyles.textSemiBoldLarge.black3,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Tout voir',
                          style: TextStyles.textSemiBoldSmall.yellow5),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeCategory(image: Media.categorie1, name: "Sénégalaise"),
                  HomeCategory(image: Media.categorie2, name: "Internationale"),
                  HomeCategory(image: Media.categorie3, name: "Saine"),
                  HomeCategory(image: Media.categorie4, name: "Dessert"),
                ],
              ),
              Gap(10),

              /*SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
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
              ),*/
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Restaurants près de vous',
                          style: TextStyles.textSemiBoldLarge.black3,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('Tout voir',
                              style: TextStyles.textSemiBoldSmall.yellow5),
                        ),
                      ],
                    ),
                    HomeRestaurants(
                      image: Media.restaurant1,
                      title: "Pizzania",
                      description:
                          "Que vous aimiez la cuisine traditionnelle ou de nouvelles saveurs, nous avons ce qu'il vous faut !",
                      time: "20-25 mins",
                      rating: "4.6",
                      distance: "7 km",
                    ),
                    Gap(15),
                    HomeRestaurants(
                      image: Media.restaurant2,
                      title: "Burger",
                      description:
                          "Que vous aimiez la cuisine traditionnelle ou de nouvelles saveurs, nous avons ce qu'il vous faut !",
                      time: "20-25 mins",
                      rating: "4.6",
                      distance: "7 km",
                    ),
                    Gap(15),
                    HomeRestaurants(
                      image: Media.restaurant3,
                      title: "Burger",
                      description:
                          "Que vous aimiez la cuisine traditionnelle ou de nouvelles saveurs, nous avons ce qu'il vous faut !",
                      time: "20-25 mins",
                      rating: "4.6",
                      distance: "7 km",
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
