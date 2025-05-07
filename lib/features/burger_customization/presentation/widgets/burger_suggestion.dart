import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class BurgerSuggestion extends StatelessWidget {
  const BurgerSuggestion({
    super.key,
    required this.picture,
    required this.name,
    required this.description,
    required this.price,
  });

  final String picture;
  final String name;
  final String description;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colours.lightThemeOrange5),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                picture,
                width: context.width * 0.2,
                height: context.height * 0.05,
                fit: BoxFit.contain,
              ),
              Gap(15),
              Text(
                name,
                style: TextStyles.textMediumtiny.white1,
              ),
              Text(
                description,
                style: TextStyles.textMediumtiny.white1,
              ),
              Gap(15),
              Text(
                price,
                style: TextStyles.textMediumtiny.white1,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -10,
          right: 5,
          child: Container(
            width: context.width * 0.06,
            height: context.height * 0.06,
            decoration: BoxDecoration(
              color: Colours.lightThemeBlack0.withAlpha(150),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.add,
                color: Colours.lightThemeWhite1,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
