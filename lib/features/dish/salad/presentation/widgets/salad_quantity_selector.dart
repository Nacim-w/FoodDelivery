import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/salad/presentation/app/salad_details_provider.dart';
import 'package:provider/provider.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SaladDetailsProvider>(context);
    return Row(
      children: [
        Column(
          children: [
            Text(
              'Salade de',
              style: TextStyles.titleSemiBoldTiny.black1,
            ),
            Gap(8),
            Text(
              '12,230 CFA',
              style: TextStyles.textMediumLargest.green5,
            ),
          ],
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colours.lightThemeGreen5, width: 1.5),
          ),
          child: IconButton(
            onPressed: provider.decrement,
            icon: const Icon(Icons.remove),
            color: Colours.lightThemeGreen5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            width: 20,
            child: Center(
              child: Text(
                provider.quantity.toString(),
                style: TextStyles.textMediumLargest.green5,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colours.lightThemeGreen5, width: 1.5),
          ),
          child: IconButton(
            onPressed: provider.increment,
            icon: const Icon(Icons.add),
            color: Colours.lightThemeGreen5,
          ),
        ),
      ],
    );
  }
}
