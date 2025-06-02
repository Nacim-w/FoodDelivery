import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/features/category/presentation/app/category_cubit.dart';
import 'package:legy/features/category/presentation/widgets/popular_dish.dart';
import 'package:legy/features/categoryDessert/presentation/widgets/category_dessert_hero.dart';
import 'package:legy/features/categoryDessert/presentation/widgets/dessert_category_appbar.dart';
import 'package:legy/features/categoryDessert/presentation/widgets/dessert_cuisine_filters.dart';
import 'package:legy/features/categoryDessert/presentation/widgets/dessert_popular_restaurant.dart';
import 'package:legy/features/dish/dessert/presentation/widgets/dessert_details.dart';

import 'package:legy/features/home/presentation/views/home_page.dart';

class CategoryDessertDetails extends StatefulWidget {
  static const routePath = "category-dessert";

  const CategoryDessertDetails({super.key});

  @override
  State<CategoryDessertDetails> createState() => _CategoryDessertDetailsState();
}

class _CategoryDessertDetailsState extends State<CategoryDessertDetails> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().fetchPopularRestaurants(3);
  }

  final List<String> dessertTitles = [
    Media.dessertPopular2,
    Media.dessertPopular1,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.adaptiveGap,
        DessertCategoryAppbar(),
        Gap(20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CategoryDessertHero(),
                Gap(15),
                DessertCuisineFilters(),
                Gap(5),
                SizedBox(
                  height: context.height * 0.32,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      InkWell(
                        onTap: () => context.go(
                          '${HomePage.routePath}/${CategoryDessertDetails.routePath}/${DessertDetails.routePath}',
                        ),
                        child: PopularDish(image: dessertTitles[0]),
                      ),
                      InkWell(
                        onTap: () => context.go(
                            '${HomePage.routePath}/${CategoryDessertDetails.routePath}/${DessertDetails.routePath}'),
                        child: PopularDish(image: dessertTitles[1]),
                      ),
                      InkWell(
                        onTap: () => context.go(
                          '${HomePage.routePath}/${CategoryDessertDetails.routePath}/${DessertDetails.routePath}',
                        ),
                        child: PopularDish(image: dessertTitles[0]),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DessertPopularRestaurant(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
