import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/features/restaurant/model/restaurant_category_model.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurant_categories.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurant_description.dart';
import 'package:legy/features/restaurant/model/restaurant_model.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurant_product_list.dart';

class RestaurantSheet extends StatelessWidget {
  final RestaurantModel restaurant;
  final List<RestaurantCategoryModel> categories;

  const RestaurantSheet({
    super.key,
    required this.restaurant,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colours.lightThemeWhite4,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          RestaurantDescription(restaurant: restaurant),
          const Gap(16),
          RestaurantCategories(categories: categories),
          const Gap(16),
          const Expanded(child: RestaurantProductList()),
        ],
      ),
    );
  }
}
