import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/features/product/presentation/widgets/product_description.dart';
import 'package:legy/core/res/styles/colours.dart';

class ProductMiddleSection extends StatelessWidget {
  const ProductMiddleSection({super.key});

  final categories = const ['Petit Déjeuner', 'pizzas', 'Plats'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colours.lightThemeWhite4,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          ProductDescription(),
          const Gap(16),
        ],
      ),
    );
  }
}
