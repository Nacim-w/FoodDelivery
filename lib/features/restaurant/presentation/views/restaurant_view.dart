import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurant_appbar.dart';
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
    final cubit = context.read<RestaurantCubit>();
    cubit.loadRestaurantById(widget.restaurantId);
    cubit.loadCategoriesByRestaurantId(widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RestaurantCubit, RestaurantState>(
      listenWhen: (previous, current) {
        return previous.categories == null &&
            current.categories != null &&
            current.categories!.isNotEmpty;
      },
      listener: (context, state) {
        if (state.categories != null && state.categories!.isNotEmpty) {
          final firstCategoryId = state.categories!.first.id;
          context.read<RestaurantCubit>().selectCategory(
                widget.restaurantId,
                firstCategoryId,
              );
        }
      },
      child: Scaffold(
        body: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final state = context.watch<RestaurantCubit>().state;

    if (state.isLoadingRestaurantById || state.isLoadingCategories) {
      return const Center(child: CircularProgressIndicator());
    }

    final restaurant = state.selectedRestaurant;
    if (restaurant == null) {
      return const Center(child: Text('Restaurant not found.'));
    }

    final categories = state.categories ?? [];
    final sortedCategories = [...categories];
    sortedCategories.sort((a, b) {
      if (a.name.toLowerCase() == 'other') return 1;
      if (b.name.toLowerCase() == 'other') return -1;
      return a.name.compareTo(b.name);
    });

    return Stack(
      children: [
        Column(
          children: [
            RestaurantCover(restaurant: restaurant),
          ],
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.only(top: 35, left: 16, right: 16),
            child: RestaurantAppbar(),
          ),
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
            child: Column(
              children: [
                Expanded(
                  child: RestaurantMiddleSection(
                    restaurant: restaurant,
                    categories: sortedCategories,
                  ),
                ),
                if (state.categoriesError != null)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text("Erreur : ${state.categoriesError!}"),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
