import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/category/presentation/widgets/category_hero.dart';
import 'package:legy/features/category/presentation/widgets/popular_restaurant.dart';
import 'package:legy/features/category/presentation/widgets/popular_dish.dart';
import 'package:legy/features/dish/presentation/widgets/dish_details.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';

class CategoryDetails extends StatefulWidget {
  static const routePath = "category";

  const CategoryDetails({super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryHero(
            onCategoryChanged: (index) {
              setState(() {
                selectedCategoryIndex = index;
              });
            },
          ),
          Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Plats populaires',
              style: TextStyles.text900fs24.brown5,
            ),
          ),
          Gap(20),
          Column(
            children: [
              SizedBox(
                height: context.height * 0.3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: InkWell(
                          child: PopularDish(),
                          onTap: () => context.go(
                            '${HomePage.routePath}/${CategoryDetails.routePath}/${DishDetails.routePath}',
                          ),
                        ));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    PopularRestaurant(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
