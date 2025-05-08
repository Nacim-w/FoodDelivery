import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_product_provider.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurant_categories.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurant_description.dart';
import 'package:provider/provider.dart';
import 'package:legy/features/restaurant/model/restaurant_model.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurant_product_container.dart';

class RestaurantMiddleSection extends StatelessWidget {
  const RestaurantMiddleSection({super.key, required this.restaurant});
  final RestaurantModel restaurant;

  final categories = const ['Petit Déjeuner', 'pizzas', 'Plats'];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RestaurantProductProvider>();
    final products = provider.products;

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
          RestaurantDescription(
            restaurant: restaurant,
          ),
          const Gap(16),
          RestaurantCategories(),
          const Gap(16),
          Expanded(
            child: ListView.separated(
              itemCount: products.length,
              separatorBuilder: (_, __) => const Gap(12),
              itemBuilder: (context, i) {
                final product = products[i];

                return InkWell(
                  onTap: () {
                    context.go(
                        '/home/restaurants/restaurant/${restaurant.id}/product');
                  },
                  borderRadius: BorderRadius.circular(16),
                  splashColor: Colours.lightThemeOrange5.withAlpha(60),
                  child: RestaurantProduct(
                    image: product['image']!,
                    title: product['title']!,
                    description: product['description']!,
                    time: product['time']!,
                    distance: product['distance']!,
                    rating: product['rating']!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
