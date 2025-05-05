import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/burger/presentation/app/burger_details_provider.dart';
import 'package:provider/provider.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BurgerDetailsProvider>(context);
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Burger',
              style: TextStyles.titleSemiBoldTiny.black1,
            ),
            Gap(8),
            Text(
              '12,230 CFA',
              style: TextStyles.textMediumLargest.brown5,
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colours.lightThemeOrange0),
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.remove,
              color: Colours.lightThemeOrange0,
              size: 16,
            ),
          ),
          onPressed: provider.decrement,
        ),
        Text(provider.quantity.toString(),
            style: TextStyles.textMediumLargest.orange0),
        IconButton(
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colours.lightThemeOrange0),
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.add,
              size: 16,
              color: Colours.lightThemeOrange0,
            ),
          ),
          onPressed: provider.increment,
        ),
      ],
    );
  }
}
