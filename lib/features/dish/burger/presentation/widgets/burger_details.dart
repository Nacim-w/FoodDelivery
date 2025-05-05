import 'package:flutter/material.dart';
import 'package:legy/features/dish/burger/presentation/app/burger_details_provider.dart';
import 'package:legy/features/dish/burger/presentation/widgets/burger_details_sheet.dart';
import 'package:legy/features/dish/burger/presentation/widgets/burger_header.dart';
import 'package:provider/provider.dart';

class BurgerDetails extends StatelessWidget {
  static const String routePath = 'burgerDetails';

  const BurgerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BurgerDetailsProvider(),
      child: Stack(
        children: [
          BurgerHeader(),
          BurgerDetailsSheet(),
        ],
      ),
    );
  }
}
