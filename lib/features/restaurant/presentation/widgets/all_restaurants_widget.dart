import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/product/presentation/widgets/product_container.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_cubit.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_state.dart';
import 'package:legy/features/restaurant/presentation/widgets/skeleton_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

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

              final itemCount = isLoading ? 6 : restaurants.length;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  if (isLoading) {
                    return const SkeletonCard();
                  }

                  final restaurant = restaurants[index];

                  return GestureDetector(
                    onTap: () => context
                        .push('/home/restaurants/restaurant/${restaurant.id}'),
                    child: RestaurantContainer(
                      image: restaurant.logo,
                      name: restaurant.nom,
                      rating: restaurant.averageRating,
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
