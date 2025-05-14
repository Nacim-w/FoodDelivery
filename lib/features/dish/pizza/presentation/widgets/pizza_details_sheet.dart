import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_add_to_cart.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_extra_list.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_selector.dart';

class PizzaDetailsSheet extends StatelessWidget {
  const PizzaDetailsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.4,
      maxChildSize: 0.6,
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
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Pizza Varities',
                  style: TextStyles.titleSemiBold.black1,
                ),
              ),
              Gap(16),
              PizzaSelector(),
              Gap(26),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: PizzaExtraList(),
              ),
              Gap(24),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AddToCartButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
