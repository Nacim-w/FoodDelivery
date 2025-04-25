import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_cubit.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_state.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurant_container.dart';

class RestaurantsWidget extends StatefulWidget {
  const RestaurantsWidget({super.key});

  @override
  State<RestaurantsWidget> createState() => _RestaurantsWidgetState();
}

class _RestaurantsWidgetState extends State<RestaurantsWidget> {
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
          Gap(5),
          Text(
            'Explorez les restaurants près de chez vous',
            style: TextStyles.textSemiBoldSmall.grey3,
          ),
          Gap(10),
          BlocBuilder<RestaurantCubit, RestaurantState>(
            builder: (context, state) {
              if (state is RestaurantsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is RestaurantsError) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is RestaurantsLoaded) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: state.restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = state.restaurants[index];
                    return GestureDetector(
                      onTap: () {
                        context.push(
                            '/home/restaurants/restaurant/${restaurant.id}');
                      },
                      child: RestaurantContainer(
                        image: restaurant.logo,
                        name: restaurant.nom,
                        rating: restaurant.averageRating,
                      ),
                    );
                  },
                );
              }
              return const Center(child: Text('No restaurants found.'));
            },
          ),
        ],
      ),
    );
  }
}
