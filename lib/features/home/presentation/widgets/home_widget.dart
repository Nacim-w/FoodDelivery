import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/category/presentation/app/provider/category_provider.dart';
import 'package:legy/features/category/presentation/widgets/category_details.dart';
import 'package:legy/features/dish/dessert/presentation/widgets/dessert_details.dart';
import 'package:legy/features/home/presentation/app/adapter/home_cubit.dart';
import 'package:legy/features/home/presentation/app/adapter/home_state.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/home/presentation/widgets/home_caroussel_widget.dart';
import 'package:legy/features/home/presentation/widgets/home_category_widget.dart';
import 'package:legy/features/home/presentation/widgets/home_restaurants_widget.dart';
import 'package:legy/features/home/presentation/widgets/home_story_widget.dart';
import 'package:legy/features/burger_customization/presentation/views/burger_customization.dart';
import 'package:legy/features/restaurant/presentation/views/all_restaurants_view.dart';

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
    final double fixedHeight = context.height * 0.18;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: Colours.lightThemeOrange0,
            ),
            height: context.height * 0.24,
            child: Column(
              children: [
                Gap(20),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: stories,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: fixedHeight - 10),
            child: GestureDetector(
              onTap: () => context.go(
                  '${HomePage.routePath}/${BurgerCustomizationScreen.routePath}'),
              child: HomeCaroussal(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: context.height * 0.4),
            child: CustomScrollView(
              slivers: [
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
                          ],
                        ),
                      ),
                      Gap(20),
                      SizedBox(
                        height: context.height * 0.15,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16), // Optional outer padding
                          children: [
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<CategoryProvider>()
                                    .changeIndex(newIndex: 0);
                                context.push(
                                    '${HomePage.routePath}/${CategoryDetails.routePath}');
                              },
                              child: HomeCategory(
                                image: Media.category3,
                                name: 'Sénégalaise',
                              ),
                            ),
                            const Gap(30),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<CategoryProvider>()
                                    .changeIndex(newIndex: 1);
                                context.push(
                                    '${HomePage.routePath}/${CategoryDetails.routePath}');
                              },
                              child: HomeCategory(
                                image: Media.category2,
                                name: 'Internationale',
                              ),
                            ),
                            const Gap(30),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<CategoryProvider>()
                                    .changeIndex(newIndex: 2);
                                context.push(
                                    '${HomePage.routePath}/${CategoryDetails.routePath}');
                              },
                              child: HomeCategory(
                                image: Media.category1,
                                name: 'Saine',
                              ),
                            ),
                            const Gap(30),
                            GestureDetector(
                              onTap: () {
                                context.push(
                                    '${HomePage.routePath}/${CategoryDetails.routePath}/${DessertDetails.routePath}');
                              },
                              child: HomeCategory(
                                image: Media.category4,
                                name: 'Desserts',
                              ),
                            ),
                          ],
                        ),
                      ),

                      /* BlocBuilder<HomeCubit, HomeState>(
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
                              children:
                                  state.categories!.take(4).map((category) {
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
                    ),*/

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
                                      '${HomePage.routePath}/${AllRestaurantsView.routePath}'),
                                  child: Text('Tout voir',
                                      style:
                                          TextStyles.textSemiBoldSmall.orange5),
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
                                              bottom: 16.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              context.push(
                                                  '/home/restaurants/restaurant/${restaurant.id}');
                                            },
                                            child: HomeRestaurants(
                                              image: restaurant.logo,
                                              title: restaurant.nom,
                                              description:
                                                  "Description goes here",
                                              time: "20-25 mins",
                                              rating:
                                                  '${restaurant.averageRating}',
                                              distance: "7 km",
                                            ),
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
