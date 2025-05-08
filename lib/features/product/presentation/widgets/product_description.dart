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
          style: TextStyles.textBoldLargest.orange0,
        ),
        Gap(5),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colours.lightThemeOrange5.withAlpha(10),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'CFA',
                    style: TextStyles.text800fs15.orange5,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Free Delivery',
                    style: TextStyles.textRegular.grey1,
                  ),
                ],
              ),

              // Center: Timer Icon + Text
              Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: Colours.lightThemeOrange5,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '20 - 30',
                    style: TextStyles.textRegular.grey1,
                  ),
                ],
              ),

              // Right: Star Icon + Rating
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colours.lightThemeOrange5,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '4.5',
                    style: TextStyles.textRegular.grey1,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Description', style: TextStyles.titleMediumTiny.black1),
              const Gap(5),
              Text(
                'Un petit déjeuner complet, parfait pour bien commencer la journée avec énergie et bonne humeur !',
                style: TextStyles.textRegular.grey1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
