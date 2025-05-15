import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_body/pizza_add_to_cart.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_body/pizza_extra_list.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_body/pizza_selector.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_body/pizza_title_number.dart';

class PizzaDetailsSheet extends StatelessWidget {
  const PizzaDetailsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      minChildSize: 0.35,
      maxChildSize: 0.35,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: const [
            BoxShadow(color: Colours.lightThemeBlack1, blurRadius: 10)
          ],
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PizzaTitleNumber(),
              const PizzaSelector(),
              const Gap(26),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: PizzaExtraList(),
              ),
              const Gap(24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: AddToCartButton(),
              ),
              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }
}
