import 'package:flutter/material.dart';
import 'package:legy/features/dish/burger/presentation/app/burger_details_provider.dart';
import 'package:legy/features/dish/burger/presentation/widgets/burger_details.dart';
import 'package:provider/provider.dart';

class BurgerView extends StatelessWidget {
  const BurgerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BurgerDetailsProvider(),
      child: BurgerDetails(),
    );
  }
}
