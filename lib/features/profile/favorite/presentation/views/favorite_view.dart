import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/widgets/black_app_bar.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/skeletonize_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/profile/favorite/presentation/app/favorite_cubit.dart';
import 'package:legy/features/profile/favorite/presentation/app/favorite_state.dart';
import 'package:legy/features/profile/favorite/presentation/views/favorite_meal_container.dart';
import 'package:legy/features/profile/favorite/presentation/views/favorite_restaurant_container.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});
  static const routePath = 'favorite';

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<FavoriteCubit>();
    cubit.fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        List restaurants = [];
        List products = [];

        if (state is FavoriteLoaded) {
          restaurants = state.favoriteRestaurants;
          products = state.favoriteProducts;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.adaptiveGap,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BlackAppBar(title: 'Favoris', onTap: context.pop),
            ),
            const Gap(30),

            // --- Restaurants Section ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Restaurants préférés',
                style: TextStyles.textSemiBold.black1,
              ),
            ),
            const Gap(15),
            SizedBox(
              height: context.height * 0.22,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state is FavoriteLoading ? 3 : restaurants.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: FavoriteRestaurantContainer(
                      image: state is FavoriteLoading
                          ? ''
                          : restaurants[index].logo,
                      name: state is FavoriteLoading
                          ? 'Loading...'
                          : restaurants[index].nom,
                      rating: state is FavoriteLoading
                          ? 0
                          : restaurants[index].averageRating,
                    ),
                  );
                },
              ),
            ),
            const Gap(15),

            // --- Products Section ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Aliments préférés',
                style: TextStyles.textSemiBold.black1,
              ),
            ),
            const Gap(15),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                height: context.height * 0.4,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 16.0,
                    childAspectRatio: 1,
                  ),
                  itemCount: state is FavoriteLoading ? 4 : products.length,
                  itemBuilder: (context, index) {
                    return FavoriteMealContainer(
                      reviews: 0,
                      price: state is FavoriteLoading
                          ? 'Loading...'
                          : '${products[index].price} CFA',
                      image: state is FavoriteLoading
                          ? ''
                          : products[index].imageUrl,
                      name: state is FavoriteLoading
                          ? 'Loading...'
                          : products[index].name,
                      rating: 0,
                    );
                  },
                ),
              ),
            ),
            const Gap(30),
          ],
        ).skeletonize(state is FavoriteLoading);
      },
    ));
  }
}
