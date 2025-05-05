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
          'Compote de fruits frais : un dessert léger et rafraîchissant, idéal pour une touche sucrée et saine !',
          style: TextStyles.textMedium.brown5,
          maxLines: 4,
        ),
      ],
    );
  }
}
