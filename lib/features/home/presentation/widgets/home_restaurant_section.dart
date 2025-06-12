import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/skeletonize_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/presentation/app/adapter/home_cubit.dart';
import 'package:legy/features/home/presentation/app/adapter/home_state.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/home/presentation/widgets/home_restaurants_widget.dart';
import 'package:legy/features/restaurant/presentation/views/all_restaurants_view.dart';

class HomeRestaurantSection extends StatefulWidget {
  HomeRestaurantSection({super.key});

  @override
  State<HomeRestaurantSection> createState() => HomeRestaurantSectionState();
}

class HomeRestaurantSectionState extends State<HomeRestaurantSection> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Restaurants près de vous',
                  style: TextStyles.textSemiBoldLarge.black1),
              TextButton(
                onPressed: () => context.push(
                    '${HomePage.routePath}/${AllRestaurantsView.routePath}'),
                child: Text('Tout voir',
                    style: TextStyles.textSemiBoldSmall.orange5),
              ),
            ],
          ),
        ),
        const Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.isLoadingRestaurants) {
                return Column(
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: HomeRestaurants(
                        image: '',
                        title: 'Loading title',
                        description: 'Loading description...',
                        time: '...',
                        rating: '...',
                        distance: '...',
                      ).skeletonize(true),
                    );
                  }),
                );
              } else if (state.restaurantsError != null) {
                return Center(child: Text(state.restaurantsError!));
              } else if (state.restaurants != null) {
                return Column(
                  children: state.restaurants!.map((restaurant) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          context.push('/home/restaurant/${restaurant.id}');
                        },
                        child: HomeRestaurants(
                          image: restaurant.logo,
                          title: restaurant.nom,
                          description:
                              "Que vous aimiez la cuisine traditionnelle ou de nouvelles saveurs, nous avons ce qu'il vous faut !",
                          time: "20-25 mins",
                          rating: '${restaurant.averageRating}',
                          distance: "7 km",
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
              return const Center(child: Text('No restaurants found.'));
            },
          ),
        ),
        const Gap(30),
      ],
    );
  }
}
