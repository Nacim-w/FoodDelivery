import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_product_provider.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurant_appbar.dart';
import 'package:provider/provider.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_cubit.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_state.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurant_cover.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurant_middle_section.dart';

class RestaurantView extends StatefulWidget {
  final String restaurantId;

  const RestaurantView({super.key, required this.restaurantId});

  @override
  State<RestaurantView> createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  @override
  void initState() {
    super.initState();
    context.read<RestaurantCubit>().loadRestaurantById(widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RestaurantProductProvider()),
      ],
      child: Scaffold(
        body: BlocBuilder<RestaurantCubit, RestaurantState>(
          builder: (context, state) {
            if (state is RestaurantsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RestaurantLoaded) {
              final restaurant = state.restaurant;

              return Stack(
                children: [
                  Column(
                    children: [
                      RestaurantCover(restaurant: restaurant),
                    ],
                  ),
                  Positioned(
                    child: Padding(
                        padding:
                            const EdgeInsets.only(top: 35, left: 16, right: 16),
                        child: RestaurantAppbar()),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(63),
                          topRight: Radius.circular(63),
                        ),
                      ),
                      child: RestaurantMiddleSection(restaurant: restaurant),
                    ),
                  ),
                ],
              );
            } else if (state is RestaurantsError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Restaurant not found.'));
          },
        ),
      ),
    );
  }
}
