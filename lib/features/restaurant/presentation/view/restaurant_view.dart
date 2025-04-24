import 'package:flutter/material.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurant_widget.dart';

class RestaurantView extends StatelessWidget {
  static const routePath = "restaurant";

  const RestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant"),
        centerTitle: true,
      ),
      body: RestaurantWidget(),
    );
  }
}
