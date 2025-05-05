import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dessert/presentation/app/dessert_details_provider.dart';
import 'package:provider/provider.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DessertDetailsProvider>(context);
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dessert',
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
              border: Border.all(color: Colours.lightThemeBrown5),
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.remove,
              color: Colours.lightThemeBrown5,
              size: 16,
            ),
          ),
          onPressed: provider.decrement,
        ),
        Text(provider.quantity.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            )),
        IconButton(
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colours.lightThemeBrown5),
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.add,
              size: 16,
              color: Colours.lightThemeBrown5,
            ),
          ),
          onPressed: provider.increment,
        ),
      ],
    );
  }
}
