import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class HomeCategory extends StatelessWidget {
  final String image;
  final String name;

  const HomeCategory({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colours.lightThemeBlack1.withAlpha(70),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                image,
                width: context.width * 0.17,
                height: context.width * 0.17,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Gap(15),
          Text(
            name,
            style: TextStyles.textBoldSmall.black3.copyWith(),
          ),
        ],
      ),
    );
  }
}
