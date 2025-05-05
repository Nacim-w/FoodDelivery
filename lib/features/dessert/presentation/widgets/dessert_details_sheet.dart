import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dessert/presentation/widgets/dessert_add_to_cart.dart';
import 'package:legy/features/dessert/presentation/widgets/price_info.dart';
import 'dessert_selector.dart';
import 'dessert_quantity_selector.dart';
import 'dessert_description_block.dart';

class DessertDetailsSheet extends StatelessWidget {
  const DessertDetailsSheet({super.key});

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
              _DragHandle(),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Aux Fins Palais',
                  style: TextStyles.titleSemiBold.black1,
                ),
              ),
              Gap(16),
              DessertSelector(),
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

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
