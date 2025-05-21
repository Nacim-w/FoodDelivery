import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_cubit.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_state.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurant_product_container.dart';

class RestaurantProductList extends StatelessWidget {
  const RestaurantProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantCubit, RestaurantState>(
      buildWhen: (previous, current) =>
          previous.products != current.products ||
          previous.isLoadingProducts != current.isLoadingProducts,
      builder: (context, state) {
        if (state.isLoadingProducts) {
          return const Center(child: CircularProgressIndicator());
        }

        final products = state.products ?? [];

        if (products.isEmpty) {
          return const Center(child: Text('Aucun produit disponible.'));
        }

        final restaurant = state.selectedRestaurant!;
        return ListView.separated(
          itemCount: products.length,
          separatorBuilder: (_, __) => const Gap(12),
          itemBuilder: (context, i) {
            final product = products[i];
            return InkWell(
              onTap: () {
                context.go(
                  '/home/restaurants/restaurant/${restaurant.id}/product',
                );
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
        );
      },
    );
  }
}
