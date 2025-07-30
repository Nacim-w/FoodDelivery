import 'package:flutter/material.dart';
import 'package:legy/features/restaurant/presentation/widgets/all_restaurants_widget.dart';

class AllRestaurantsView extends StatelessWidget {
  static const routePath = "restaurants";

  const AllRestaurantsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AllRestaurantsWidget();
  }
}
