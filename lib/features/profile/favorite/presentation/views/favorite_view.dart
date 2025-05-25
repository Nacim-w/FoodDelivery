import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/widgets/black_app_bar.dart';
import 'package:legy/core/extension/media_extension.dart';
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
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavoriteError) {
            return Center(child: Text('Erreur : ${state.message}'));
          }

          if (state is FavoriteLoaded) {
            final restaurants = state.favoriteRestaurants;
            final products = state.favoriteProducts;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BlackAppBar(title: 'Favoris', onTap: context.pop),
                ),
                const Gap(30),

                // --- Restaurants Section ---
                if (restaurants.isNotEmpty) ...[
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
                      itemCount: restaurants.length,
                      itemBuilder: (_, index) {
                        final restaurant = restaurants[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: FavoriteRestaurantContainer(
                            image: restaurant.logo,
                            name: restaurant.nom,
                            rating: restaurant.averageRating,
                          ),
                        );
                      },
                    ),
                  ),
                  const Gap(15),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Aucun restaurant favori trouvé.',
                      style: TextStyles.textRegular.black2,
                    ),
                  ),
                  const Gap(15),
                ],

                // --- Products Section ---
                if (products.isNotEmpty) ...[
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 16.0,
                          childAspectRatio: 1,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return FavoriteMealContainer(
                            reviews: 1.2, // replace if you have real data
                            price: '${product.price} CFA',
                            image: product.imageUrl,
                            name: product.name,
                            rating: 4.8, // replace if you have real data
                          );
                        },
                      ),
                    ),
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Aucun aliment favori trouvé.',
                      style: TextStyles.textRegular.black2,
                    ),
                  ),
                ],

                const Gap(30),
              ],
            );
          }

          // Default empty state (should rarely hit)
          return const Center(child: Text('Aucun favori trouvé.'));
        },
      ),
    );
  }
}
