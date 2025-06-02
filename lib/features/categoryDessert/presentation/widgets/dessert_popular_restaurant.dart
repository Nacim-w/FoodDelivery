import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/category/presentation/app/category_cubit.dart';
import 'package:legy/features/category/presentation/app/category_state.dart';
import 'package:legy/features/category/presentation/app/provider/category_provider.dart';
import 'package:legy/features/categoryDessert/presentation/widgets/dessert_restaurant.dart';

class DessertPopularRestaurant extends StatelessWidget {
  const DessertPopularRestaurant({super.key});

  @override
  Widget build(BuildContext context) {
    final accentColor = context.watch<CategoryProvider>().color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Restaurants Populaires',
          style: TextStyles.text900fs24.brown5,
        ),
        Gap(15),
        BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryLoaded) {
              final displayedRestaurants = state.restaurants.take(5).toList();
              return Column(
                children: displayedRestaurants.map((r) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () => context.push('/home/restaurant/${r.id}'),
                        child: DessertRestaurant(
                          image: r.logoUrl,
                          title: r.nom,
                          description:
                              'Note moyenne: ${r.averageRating.toStringAsFixed(1)} ★',
                          time:
                              '15-20 mins', // Replace with real data if available
                          distance:
                              '3 km', // Replace with real data if available
                          rating: r.averageRating.toStringAsFixed(1),
                          accentColor: accentColor,
                        ),
                      ),
                      Gap(15),
                    ],
                  );
                }).toList(),
              );
            } else if (state is CategoryError) {
              return Text(state.message);
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
