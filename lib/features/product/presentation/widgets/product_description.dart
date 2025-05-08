import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Menu Petit Déjeuner', style: TextStyles.titleMediumTiny.black1),
        const Gap(5),
        Text(
          '12,230 CFA',
          style: TextStyles.textBoldLargest,
        ),
        Row(
          children: [
            Icon(Icons.star, color: Colours.lightThemeYellow5),
            const Gap(5),
            Text("4.5", style: TextStyles.textMediumLarge.black1),
            const Gap(20),
            Icon(Icons.access_time_outlined,
                color: Colours.lightThemeBlack1, size: 20),
            const Gap(5),
            Text("25-35 mins", style: TextStyles.textMediumLarge.black1),
            const Gap(20),
            Icon(Icons.circle, color: Colours.lightThemeBlack1, size: 8),
            const Gap(5),
            Text("7 km", style: TextStyles.textMediumLarge.black1),
          ],
        ),
      ],
    );
  }
}
