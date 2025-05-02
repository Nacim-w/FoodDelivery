import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/presentation/widgets/add_to_cart.dart';
import 'package:legy/features/dish/presentation/widgets/extra_list.dart';
import 'package:legy/features/dish/presentation/widgets/price_info.dart';
import 'salad_selector.dart';
import 'quantity_selector.dart';
import 'description_block.dart';
import 'ingredients_list.dart';

class DishDetailsSheet extends StatelessWidget {
  const DishDetailsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DragHandle(),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('La table verte', style: TextStyles.titleBoldLarge),
              ),
              Gap(16),
              SaladSelector(),
              Gap(16),
              Padding(
                padding: EdgeInsets.all(16),
                child: QuantitySelector(),
              ),
              Gap(16),
              Padding(
                padding: EdgeInsets.all(16),
                child: PriceInfoRow(),
              ),
              Gap(10),
              Padding(
                padding: EdgeInsets.all(16),
                child: DescriptionBlock(),
              ),
              IngredientsList(),
              Gap(24),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ExtrasList(),
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
