import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/skeletonize_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_cubit.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_state.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurant_product_container.dart';
import 'package:legy/features/restaurant/presentation/widgets/product_skeleton_card.dart'; // Add this

class RestaurantProductList extends StatelessWidget {
  const RestaurantProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantCubit, RestaurantState>(
      buildWhen: (previous, current) =>
          previous.products != current.products ||
          previous.isLoadingProducts != current.isLoadingProducts,
      builder: (context, state) {
        final isLoading = state.isLoadingProducts;
        final products = state.products ?? [];

        final restaurant = state.selectedRestaurant;

        if (!isLoading && products.isEmpty) {
          return const Center(child: Text('Aucun produit disponible.'));
        }

        final itemCount = isLoading ? 5 : products.length;

        return ListView.separated(
          itemCount: itemCount,
          separatorBuilder: (_, __) => const Gap(12),
          itemBuilder: (context, i) {
            if (isLoading) {
              return const ProductSkeletonCard();
            }

            final product = products[i];
            return InkWell(
              onTap: () {
                if (restaurant != null) {
                  context.go(
                    '/home/restaurants/restaurant/${restaurant.id}/product',
                    extra: product,
                  );
                }
              },
              borderRadius: BorderRadius.circular(16),
              splashColor: Colours.lightThemeOrange5.withAlpha(60),
              child: RestaurantProduct(
                image: product.imageUrl,
                title: product.name,
                description: product.description,
                time: '20',
                distance: '7',
                rating: '4.6',
              ),
            );
          },
        ).skeletonize(isLoading); // Apply shimmer across entire list
      },
    );
  }
}
