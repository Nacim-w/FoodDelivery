import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/product/presentation/widgets/recommanded_container.dart';

class ProductRecommanded extends StatelessWidget {
  const ProductRecommanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recommandé pour vous', style: TextStyles.textSemiBoldLarge),
            TextButton(
              onPressed: () {},
              child: Text(
                'Voir tout',
                style: TextStyles.textMedium.orange5,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RecommandedContainer(
              image: Media.recommandedProduct2,
            ),
            RecommandedContainer(
              image: Media.recommandedProduct1,
            )
          ],
        ),
      ],
    );
  }
}
