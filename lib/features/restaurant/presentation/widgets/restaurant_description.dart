import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/restaurant/model/restaurant_model.dart';

class RestaurantDescription extends StatelessWidget {
  const RestaurantDescription({super.key, required this.restaurant});
  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(restaurant.nom, style: TextStyles.titleMediumTiny.black1),
        const Gap(5),
        Row(
          children: [
            Icon(Icons.star, color: Colours.lightThemeYellow5),
            const Gap(5),
            Text("${restaurant.averageRating}",
                style: TextStyles.textMediumLarge.black1),
            const Gap(20),
            Icon(Icons.access_time_outlined,
                color: Colours.lightThemeBlack1, size: 20),
            const Gap(5),
            Text("25-35 mins", style: TextStyles.textMediumLarge.black1),
            const Gap(20),
            Icon(Icons.circle, color: Colours.lightThemeBlack1, size: 8),
            const Gap(5),
            Text("7 km", style: TextStyles.textMediumLarge.black1),
          ],
        ),
      ],
    );
  }
}
