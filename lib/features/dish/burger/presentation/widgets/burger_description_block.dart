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
          'Burger est une gamme de produits de hamburgers vendue par les franchises japonaises du fast-food Burger King.',
          style: TextStyles.textMedium.orange0,
          maxLines: 4,
        ),
      ],
    );
  }
}
