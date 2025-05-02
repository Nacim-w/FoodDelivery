import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';

class DescriptionBlock extends StatelessWidget {
  const DescriptionBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text('Description', style: TextStyles.titleSemiBoldTiny),
        SizedBox(height: 8),
        Text(
          'La Salade Verte Fraîche est un plat sain et rafraîchissant, apprécié pour ses légumes croquants et sa délicieuse vinaigrette. Parfait pour un repas léger et nutritif !',
          style: TextStyles.textMedium.green5,
          maxLines: 4,
        ),
      ],
    );
  }
}
