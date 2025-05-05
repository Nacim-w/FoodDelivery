import 'package:flutter/material.dart';
import 'package:legy/features/dish/salad/presentation/app/dish_details_provider.dart';
import 'package:legy/features/dish/salad/presentation/widgets/dish_details_sheet.dart';
import 'package:legy/features/dish/salad/presentation/widgets/dish_header.dart';
import 'package:provider/provider.dart';

class DishDetails extends StatelessWidget {
  static const String routePath = 'dishDetails';

  const DishDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DishDetailsProvider(),
      child: Stack(
        children: [
          DishHeader(),
          DishDetailsSheet(),
        ],
      ),
    );
  }
}
