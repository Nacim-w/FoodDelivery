import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class PriceInfoRow extends StatelessWidget {
  const PriceInfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'CFA',
          style: TextStyles.textMediumLarge.brown5,
        ),
        Gap(8),
        Text(
          'Livraison gratuite',
          style: TextStyles.textMediumLarge.brown5,
        ),
        Gap(8),
        Icon(Icons.timer, size: 16, color: Colours.lightThemeBrown5),
        Text(
          '20-25 min',
          style: TextStyles.textMediumLarge.brown5,
        ),
        Gap(8),
        Icon(Icons.star, size: 16, color: Colours.lightThemeBrown5),
        Text(
          '4.5',
          style: TextStyles.textMediumLarge.brown5,
        ),
      ],
    );
  }
}
