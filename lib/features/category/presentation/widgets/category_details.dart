import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/category/presentation/app/provider/category_provider.dart';
import 'package:legy/features/category/presentation/widgets/category_appbar.dart';
import 'package:legy/features/category/presentation/widgets/category_hero.dart';
import 'package:legy/features/category/presentation/widgets/cuisine_filters.dart';
import 'package:legy/features/category/presentation/widgets/popular_restaurant.dart';
import 'package:legy/features/category/presentation/widgets/popular_dish.dart';
import 'package:legy/features/dish/burger/presentation/widgets/burger_details.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_body/pizza_details.dart';
import 'package:legy/features/dish/salad/presentation/widgets/salad_details.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';

class CategoryDetails extends StatefulWidget {
  static const routePath = "category";

  const CategoryDetails({super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  final List<String> categoryTitles = [
    Media.categoryDish1,
    Media.categoryDish2,
    Media.categoryDish3,
    Media.categoryDish4,
    Media.categoryDish5,
    Media.categoryDish6,
  ];
  final List<String> categoryRoutes = [
    BurgerDetails.routePath, // index 0
    PizzaDetails.routePath, // index 1
    SaladDetails.routePath, // index 2
  ];

  @override
  Widget build(BuildContext context) {
    final index = context.watch<CategoryProvider>().index;
    final selectedRoute = categoryRoutes.asMap().containsKey(index)
        ? categoryRoutes[index]
        : BurgerDetails.routePath;
    return Column(
      children: [
        Gap(60),
        CategoryAppBar(),
        Gap(20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CategoryHero(),
                Gap(15),
                index == 1
                    ? CuisineFilters()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Plats populaires',
                          style: TextStyles.text900fs24.brown5,
                        ),
                      ),
                Gap(5),
                SizedBox(
                  height: context.height * 0.32,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      InkWell(
                        onTap: () => context.go(
                          '${HomePage.routePath}/${CategoryDetails.routePath}/$selectedRoute',
                        ),
                        child: PopularDish(image: categoryTitles[index * 2]),
                      ),
                      InkWell(
                        onTap: () => context.go(
                          '${HomePage.routePath}/${CategoryDetails.routePath}/$selectedRoute',
                        ),
                        child:
                            PopularDish(image: categoryTitles[index * 2 + 1]),
                      ),
                      InkWell(
                        onTap: () => context.go(
                          '${HomePage.routePath}/${CategoryDetails.routePath}/$selectedRoute',
                        ),
                        child: PopularDish(image: categoryTitles[index * 2]),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: PopularRestaurant(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
