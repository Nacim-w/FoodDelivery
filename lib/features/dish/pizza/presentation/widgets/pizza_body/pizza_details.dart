import 'package:flutter/material.dart';
import 'package:legy/features/dish/pizza/presentation/app/pizza_details_provider.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_body/pizza_details_sheet.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_body/pizza_header.dart';
import 'package:provider/provider.dart';

class PizzaDetails extends StatelessWidget {
  static const String routePath = 'pizzaDetails';

  const PizzaDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PizzaDetailsProvider(),
      child: Stack(
        children: [
          PizzaHeader(),
          PizzaDetailsSheet(),
        ],
      ),
    );
  }
}
