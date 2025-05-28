import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/styles/colours.dart';

class ProductSkeletonCard extends StatelessWidget {
  const ProductSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cardHeight = context.height * 0.1;
    final imageWidth = context.width * 0.25;
    final textWidth = context.width * 0.52;

    return Container(
      height: cardHeight,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colours.lightThemeWhite1,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colours.lightThemeBlack1.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Row(
          children: [
            // Image placeholder
            Container(
              height: cardHeight,
              width: imageWidth,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const Gap(10),
            // Text placeholder
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 14,
                  width: textWidth * 0.8,
                  color: Colors.grey[300],
                ),
                const Gap(5),
                Container(
                  height: 10,
                  width: textWidth,
                  color: Colors.grey[300],
                ),
                const Gap(5),
                Container(
                  height: 10,
                  width: textWidth * 0.7,
                  color: Colors.grey[300],
                ),
                const Spacer(),
                Row(
                  children: List.generate(3, (_) {
                    return Row(
                      children: [
                        Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const Gap(5),
                        Container(
                          height: 12,
                          width: 30,
                          color: Colors.grey[300],
                        ),
                        const Gap(20),
                      ],
                    );
                  }),
                ),
                const Gap(15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
