import 'package:flutter/material.dart';
import 'package:legy/features/dish/salad/presentation/app/dish_details_provider.dart';
import 'package:legy/features/dish/salad/presentation/widgets/dish_details.dart';
import 'package:provider/provider.dart';

class DishView extends StatelessWidget {
  const DishView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DishDetailsProvider(),
      child: DishDetails(),
    );
  }
}
