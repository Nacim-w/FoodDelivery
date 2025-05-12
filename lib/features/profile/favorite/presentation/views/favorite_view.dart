import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/widgets/black_app_bar.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/profile/favorite/presentation/views/favorite_meal_container.dart';
import 'package:legy/features/profile/favorite/presentation/views/favorite_restaurant_container.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});
  static const routePath = 'favorite';

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final List<String> favoriteMeals = [
    Media.favoriteMeal1,
    Media.favoriteMeal2,
    Media.favoriteMeal3,
    Media.favoriteMeal4,
    Media.favoriteMeal5,
    Media.favoriteMeal6,
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: BlackAppBar(title: 'Favoris', onTap: context.pop),
          ),
          Gap(30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Restaurants préférés',
              style: TextStyles.textSemiBold.black1,
            ),
          ),
          Gap(15),
          SizedBox(
            height: context.height * 0.22,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: FavoriteRestaurantContainer(
                    image: Media.restaurant1,
                    name: 'Restaurant $index',
                    rating: 4.5,
                  ),
                );
              },
            ),
          ),
          Gap(15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Aliments préférés',
              style: TextStyles.textSemiBold.black1,
            ),
          ),
          Gap(15),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SizedBox(
              height: context.height * 0.4,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 1,
                ),
                itemCount: favoriteMeals.length,
                itemBuilder: (context, index) {
                  return FavoriteMealContainer(
                    reviews: 1.2,
                    price: '5.00 CFA',
                    image: favoriteMeals[index],
                    name: 'Noodles',
                    rating: 4.8,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
