import 'package:flutter/material.dart';
import 'package:legy/features/dish/pizza/presentation/app/pizza_details_provider.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_body/pizza_details.dart';
import 'package:provider/provider.dart';

class PizzaView extends StatelessWidget {
  const PizzaView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PizzaDetailsProvider(),
      child: PizzaDetails(),
    );
  }
}
