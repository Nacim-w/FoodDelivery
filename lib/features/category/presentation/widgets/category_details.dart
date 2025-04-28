import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/category/presentation/widgets/category_hero.dart';
import 'package:legy/features/category/presentation/widgets/popular_restaurant.dart';
import 'package:legy/features/category/presentation/widgets/popular_dish.dart';

class CategoryDetails extends StatefulWidget {
  static const routePath = "category";

  const CategoryDetails({super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryHero(),
          Text(
            'Plats populaires',
            style: TextStyles.text900fs24.brown5,
          ),
          SizedBox(
            height: context.height * 0.3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: PopularDish(),
                );
              },
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: -30,
                child: Image.asset(Media.background),
              ),
              PopularRestaurant(),
            ],
          )
        ],
      ),
    );
  }
}
