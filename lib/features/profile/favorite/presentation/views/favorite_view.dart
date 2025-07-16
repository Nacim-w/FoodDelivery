import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/res/media.dart';
import 'package:lottie/lottie.dart'; // Add this for Lottie animation
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

          final bool isLoading = state is FavoriteLoading;
          final bool noRestaurants = !isLoading && restaurants.isEmpty;
          final bool noProducts = !isLoading && products.isEmpty;

          // Show Lottie animation if both empty (and not loading)
          if (!isLoading && noRestaurants && noProducts) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                context.adaptiveGap,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BlackAppBar(title: 'Favoris', onTap: context.pop),
                ),
                Gap(context.height * 0.2),
                Center(
                  child: Lottie.asset(
                    Media.emptyFavorite,
                    width: context.width * 0.6,
                    height: context.width * 0.6,
                    fit: BoxFit.contain,
                  ),
                ),
                const Gap(20),
                Text(
                  'Vous n\'avez aucun favori pour le moment.',
                  style: TextStyles.textSemiBoldLarge.black1,
                ),
                const Gap(30),
              ],
            );
          }

          // Else show what is available (hide empty sections)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.adaptiveGap,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BlackAppBar(title: 'Favoris', onTap: context.pop),
              ),
              const Gap(30),

              // --- Restaurants Section (only if not empty) ---
              if (!noRestaurants) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Restaurants préférés',
                    style: TextStyles.textSemiBold.orange5,
                  ),
                ),
                const Gap(40),
                SizedBox(
                  height: context.height * 0.22,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: isLoading ? 3 : restaurants.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: GestureDetector(
                          onTap: () => context.go(
                            '/home/restaurant/${restaurants[index].id}',
                          ),
                          child: FavoriteRestaurantContainer(
                            image: isLoading ? '' : restaurants[index].logo,
                            name: isLoading
                                ? 'Loading...'
                                : restaurants[index].nom,
                            rating: isLoading
                                ? 0
                                : restaurants[index].averageRating,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Gap(40),
              ],

              // --- Products Section (only if not empty) ---
              if (!noProducts) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Aliments préférés',
                    style: TextStyles.textSemiBold.orange5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: SizedBox(
                    height: context.height * 0.4,
                    child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 16.0,
                        childAspectRatio: 1,
                      ),
                      itemCount: isLoading ? 4 : products.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => context.go(
                            '/home/restaurant/${products[index].restaurantId}/product/${products[index].id}',
                          ),
                          child: FavoriteMealContainer(
                            reviews: 0,
                            price: isLoading ? 0.0 : products[index].price,
                            image: isLoading ? '' : products[index].imageUrl,
                            name:
                                isLoading ? 'Loading...' : products[index].name,
                            rating: 0,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const Gap(30),
              ],
            ],
          ).skeletonize(isLoading);
        },
      ),
    );
  }
}
