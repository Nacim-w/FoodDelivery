import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/burger/presentation/widgets/burger_add_to_cart.dart';
import 'package:legy/features/dish/burger/presentation/widgets/burger_selector.dart';
import 'package:legy/features/dish/burger/presentation/widgets/price_info.dart';
import 'burger_quantity_selector.dart';
import 'burger_description_block.dart';

class BurgerDetailsSheet extends StatelessWidget {
  const BurgerDetailsSheet({super.key});

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
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Le Coin des Burgers',
                  style: TextStyles.titleSemiBold.black1,
                ),
              ),
              Gap(16),
              BurgerSelector(),
              Gap(26),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: QuantitySelector(),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: PriceInfoRow(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: DescriptionBlock(),
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
