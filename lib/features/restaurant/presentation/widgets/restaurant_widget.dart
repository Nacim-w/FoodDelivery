import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurant_container.dart';

class RestaurantWidget extends StatefulWidget {
  const RestaurantWidget({super.key});

  @override
  State<RestaurantWidget> createState() => _RestaurantWidgetState();
}

class _RestaurantWidgetState extends State<RestaurantWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Près de chez vous !',
            style: TextStyles.textSemiBoldLarge.black1,
          ),
          Gap(5),
          Text(
            'Explorez les restaurants près de chez vous',
            style: TextStyles.textSemiBoldSmall.grey3,
          ),
          Gap(10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return RestaurantContainer(
                image: Media.restaurant1,
              );
            },
          ),
        ],
      ),
    );
  }
}
