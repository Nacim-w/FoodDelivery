import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/widgets/black_app_bar.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_cubit.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_state.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurant_container.dart';
import 'package:legy/features/restaurant/presentation/widgets/skeleton_card.dart';

class AllRestaurantsWidget extends StatefulWidget {
  const AllRestaurantsWidget({super.key});

  @override
  State<AllRestaurantsWidget> createState() => _AllRestaurantsWidgetState();
}

class _AllRestaurantsWidgetState extends State<AllRestaurantsWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<RestaurantCubit>().loadRestaurants();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantCubit, RestaurantState>(
      builder: (context, state) {
        final isLoading = state.isLoadingRestaurants;
        final allRestaurants = state.restaurants ?? [];

        if (state.restaurantsError != null) {
          return Center(
            child: Text("Erreur : ${state.restaurantsError!}"),
          );
        }

        final query = _searchController.text.toLowerCase().trim();
        final filtered = query.isEmpty
            ? allRestaurants
            : allRestaurants
                .where((r) => r.nom.toLowerCase().contains(query))
                .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.adaptiveGap,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BlackAppBar(title: 'Restaurants', onTap: context.pop),
            ),
            // Top section with and search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explorez tous les restaurants',
                    style: TextStyles.textSemiBoldLarge.black1,
                  ),
                  const Gap(5),
                  Text(
                    '',
                    style: TextStyles.textSemiBoldSmall.grey3,
                  ),
                  const Gap(10),
                  Center(
                    child: SizedBox(
                      width: context.width * 0.8,
                      height: 45,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(30),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colours.lightThemeOrange5,
                          borderRadius: BorderRadius.circular(99),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(99),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colours.lightThemeWhite3,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colours.lightThemeOrange0,
                                ),
                                hintText: "Rechercher un Restaurant",
                                hintStyle: TextStyles.textMediumSmall.grey3,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              style: TextStyles.textMediumSmall,
                              onChanged: (_) => setState(() {}),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Scrollable content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: isLoading
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: 6,
                        itemBuilder: (_, __) => const SkeletonCard(),
                      )
                    : filtered.isEmpty
                        ? const Center(
                            child: Text('Aucun restaurant trouvé.'),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 3 / 4,
                            ),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final restaurant = filtered[index];
                              return GestureDetector(
                                key: ValueKey(restaurant.id),
                                onTap: () => context.push(
                                    '/home/restaurants/restaurant/${restaurant.id}'),
                                child: RestaurantContainer(
                                  image: restaurant.logo,
                                  name: restaurant.nom,
                                  rating: restaurant.averageRating,
                                ),
                              );
                            },
                          ),
              ),
            ),
          ],
        );
      },
    );
  }
}
