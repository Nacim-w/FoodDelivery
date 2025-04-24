import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';

class CaroussalItems extends StatelessWidget {
  const CaroussalItems(
      {super.key,
      required this.image,
      required this.title,
      required this.body,
      required this.description});
  final String image;
  final String title;
  final String body;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyles.textRegularSmallest.white1),
                  Gap(20),
                  SizedBox(
                    width: context.width * 0.4,
                    child: AutoSizeText(
                      "PROFITEZ DE LA DÉLICIEUSE CRÊPE",
                      style: TextStyles.textSemiBoldLarge.white1,
                      maxLines: 2,
                    ),
                  ),
                  Gap(20),
                  Text(
                    " 60% de réduction",
                    style: TextStyles.textMedium.white1,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
