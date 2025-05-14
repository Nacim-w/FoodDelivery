import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/category/presentation/app/provider/category_provider.dart';
import 'package:legy/features/category/presentation/widgets/category_restaurant.dart';

class PopularRestaurant extends StatelessWidget {
  const PopularRestaurant({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Restaurants Populaires',
          style: TextStyles.text900fs24.brown5,
        ),
        Gap(15),
        CategoryRestaurant(
          image: Media.restaurant1,
          title: 'Le Festin du Chef',
          description:
              'Que vous aimiez la cuisine traditionnelle ou de nouvelles saveurs, nous avons ce qu\'il vous faut !',
          time: '20-25 mins',
          distance: '7',
          rating: '4.6',
          accentColor: context.watch<CategoryProvider>().color,
        ),
        Gap(15),
        CategoryRestaurant(
          image: Media.restaurant1,
          title: 'Maison Gourmande',
          description: 'Fusions internationales pour palais curieux.',
          time: '18-22 mins',
          distance: '5',
          rating: '4.8',
          accentColor: context.watch<CategoryProvider>().color,
        ),
        Gap(15),
        CategoryRestaurant(
          image: Media.restaurant1,
          title: 'Repas Santé',
          description: 'Ingrédients frais, options équilibrées.',
          time: '25-30 mins',
          distance: '6',
          rating: '4.5',
          accentColor: context.watch<CategoryProvider>().color,
        ),
      ],
    );
  }
}
