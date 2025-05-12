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
import 'package:legy/features/category/presentation/widgets/popular_restaurant.dart';
import 'package:legy/features/category/presentation/widgets/popular_dish.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_details.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(35),
        CategoryAppBar(),
        Gap(20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20),
                CategoryHero(),
                Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Plats populaires',
                    style: TextStyles.text900fs24.brown5,
                  ),
                ),
                Gap(20),
                SizedBox(
                    height: context.height * 0.3,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: InkWell(
                            onTap: () => context.go(
                              '${HomePage.routePath}/${CategoryDetails.routePath}/${PizzaDetails.routePath}',
                            ),
                            child: PopularDish(
                                image: categoryTitles[
                                    context.watch<CategoryProvider>().index *
                                            2 +
                                        1]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: InkWell(
                            onTap: () => context.go(
                              '${HomePage.routePath}/${CategoryDetails.routePath}/${PizzaDetails.routePath}',
                            ),
                            child: PopularDish(
                                image: categoryTitles[
                                    context.watch<CategoryProvider>().index *
                                        2]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: InkWell(
                            onTap: () => context.go(
                              '${HomePage.routePath}/${CategoryDetails.routePath}/${PizzaDetails.routePath}',
                            ),
                            child: PopularDish(
                                image: categoryTitles[
                                    context.watch<CategoryProvider>().index *
                                            2 +
                                        1]),
                          ),
                        ),
                      ],
                    )),
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
