import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
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
        IconButton(
          icon: const Icon(Icons.remove, size: 16),
          onPressed: provider.decrement,
        ),
        Text(provider.quantity.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        IconButton(
          icon: const Icon(Icons.add, size: 16),
          onPressed: provider.increment,
        ),
      ],
    );
  }
}
