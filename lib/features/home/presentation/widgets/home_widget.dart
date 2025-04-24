import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/presentation/app/adapter/home_cubit.dart';
import 'package:legy/features/home/presentation/app/adapter/home_state.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/home/presentation/widgets/home_caroussel_widget.dart';
import 'package:legy/features/home/presentation/widgets/home_category_widget.dart';
import 'package:legy/features/home/presentation/widgets/home_restaurants_widget.dart';
import 'package:legy/features/home/presentation/widgets/home_story_widget.dart';
import 'package:legy/features/restaurant/presentation/view/restaurant_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadCategories();
    context.read<HomeCubit>().loadRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    final double storyHeight = context.height * 0.12;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: storyHeight,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: stories, // Ensure you have a 'stories' list available
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: storyHeight),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Offres spéciales",
                            style: TextStyles.textSemiBoldLarge.black3),
                        TextButton(
                          onPressed: () {},
                          child: Text("Tout voir",
                              style: TextStyles.textSemiBoldSmall.yellow5),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: HomeCaroussal()),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Catégories',
                                style: TextStyles.textSemiBoldLarge.black3),
                            TextButton(
                              onPressed: () {},
                              child: Text('Tout voir',
                                  style: TextStyles.textSemiBoldSmall.yellow5),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state.isLoadingCategories) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state.categoriesError != null) {
                            return Center(child: Text(state.categoriesError!));
                          } else if (state.categories != null) {
                            return SingleChildScrollView(
                              scrollDirection:
                                  Axis.horizontal, // Horizontal scroll
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: state.categories!.map((category) {
                                  return HomeCategory(
                                      image: Media.categorie1,
                                      name: category.name);
                                }).toList(),
                              ),
                            );
                          }
                          return const Center(
                              child: Text('Something went wrong.'));
                        },
                      ),
                      Gap(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Restaurants près de vous',
                                    style: TextStyles.textSemiBoldLarge.black3),
                                TextButton(
                                  onPressed: () => context.push(
                                      '${HomePage.routePath}/${RestaurantView.routePath}'),
                                  child: Text('Tout voir',
                                      style:
                                          TextStyles.textSemiBoldSmall.yellow5),
                                ),
                              ],
                            ),
                            BlocBuilder<HomeCubit, HomeState>(
                              builder: (context, state) {
                                if (state.isLoadingRestaurants) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state.restaurantsError != null) {
                                  return Center(
                                      child: Text(state.restaurantsError!));
                                } else if (state.categories != null) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      children:
                                          state.restaurants!.map((restaurant) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom:
                                                  16.0), // Add gap between items
                                          child: HomeRestaurants(
                                            image: restaurant.logo,
                                            // Dynamic image
                                            title: restaurant.nom,
                                            // Dynamic name
                                            description:
                                                "Description goes here",
                                            time: "20-25 mins",
                                            rating: "4.6",
                                            distance: "7 km",
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                }
                                return const Center(
                                    child: Text('No restaurants found.'));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
