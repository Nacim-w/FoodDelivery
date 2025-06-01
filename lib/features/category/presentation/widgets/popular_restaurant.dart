import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/category/presentation/app/category_cubit.dart';
import 'package:legy/features/category/presentation/app/category_state.dart';
import 'package:legy/features/category/presentation/app/provider/category_provider.dart';
import 'package:legy/features/category/presentation/widgets/category_restaurant.dart';

class PopularRestaurant extends StatelessWidget {
  const PopularRestaurant({super.key});

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
                      CategoryRestaurant(
                        image: r.logoUrl,
                        title: r.nom,
                        description:
                            'Note moyenne: ${r.averageRating.toStringAsFixed(1)} ★',
                        time:
                            '15-20 mins', // You can adjust or fetch real values
                        distance: '3 km', // You can adjust or fetch real values
                        rating: r.averageRating.toStringAsFixed(1),
                        accentColor: accentColor,
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
