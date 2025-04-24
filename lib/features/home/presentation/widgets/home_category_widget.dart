import 'package:flutter/material.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipOval(
            child: Image.asset(
              image,
              width: context.width * 0.22,
              height: context.width * 0.22,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            name,
            style: TextStyles.textBoldSmall.black3.copyWith(
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(2, 3),
                  blurRadius: 15.0,
                  color: Colours.lightThemeBlack1.withAlpha(127),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
