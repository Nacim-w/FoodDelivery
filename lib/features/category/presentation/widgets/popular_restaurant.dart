import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/presentation/widgets/home_restaurants_widget.dart';

class PopularRestaurant extends StatefulWidget {
  const PopularRestaurant({super.key});

  @override
  State<PopularRestaurant> createState() => _PopularRestaurantState();
}

class _PopularRestaurantState extends State<PopularRestaurant> {
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
        HomeRestaurants(
          image: Media.restaurant1,
          title: 'Le Festin du Chef',
          description: 'description',
          time: '20-25 mins',
          distance: '7',
          rating: '4.6',
        ),
        Gap(15),
        HomeRestaurants(
          image: Media.restaurant1,
          title: 'Le Festin du Chef',
          description: 'description',
          time: '20-25 mins',
          distance: '7',
          rating: '4.6',
        ),
        Gap(15),
        HomeRestaurants(
          image: Media.restaurant1,
          title: 'Le Festin du Chef',
          description: 'description',
          time: '20-25 mins',
          distance: '7',
          rating: '4.6',
        )
      ],
    );
  }
}
