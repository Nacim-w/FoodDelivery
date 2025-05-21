import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/skeletonize_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_cubit.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_state.dart';

class AllRestaurantsWidget extends StatefulWidget {
  const AllRestaurantsWidget({super.key});

  @override
  State<AllRestaurantsWidget> createState() => _AllRestaurantsWidgetState();
}

class _AllRestaurantsWidgetState extends State<AllRestaurantsWidget> {
  @override
  void initState() {
    super.initState();
    context.read<RestaurantCubit>().loadRestaurants();
  }

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
          const Gap(5),
          Text(
            'Explorez les restaurants près de chez vous',
            style: TextStyles.textSemiBoldSmall.grey3,
          ),
          const Gap(10),
          BlocBuilder<RestaurantCubit, RestaurantState>(
            builder: (context, state) {
              final isLoading = state.isLoadingRestaurants;
              final restaurants = state.restaurants ?? [];

              if (state.restaurantsError != null) {
                return Center(
                  child: Text("Erreur : ${state.restaurantsError!}"),
                );
              }

              if (!isLoading && restaurants.isEmpty) {
                return const Center(child: Text('Aucun restaurant trouvé.'));
              }

              final displayList =
                  isLoading ? List.generate(6, (_) => null) : restaurants;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: displayList.length,
                itemBuilder: (context, index) {
                  final restaurant = displayList[index];
                  return GestureDetector(
                    onTap: restaurant != null
                        ? () => context.push(
                            '/home/restaurants/restaurant/${restaurant.id}')
                        : null,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colours.lightThemeGrey2.withAlpha(100),
                                image: restaurant?.logo != null
                                    ? DecorationImage(
                                        image: NetworkImage(restaurant!.logo),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              restaurant?.nom ?? 'Nom du restaurant',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.orange, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  restaurant?.averageRating
                                          .toStringAsFixed(1) ??
                                      '0.0',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ).skeletonize(isLoading);
            },
          ),
        ],
      ),
    );
  }
}
