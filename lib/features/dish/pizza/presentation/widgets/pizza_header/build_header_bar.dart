import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class BuildHeaderBar extends StatefulWidget {
  const BuildHeaderBar({super.key});

  @override
  State<BuildHeaderBar> createState() => _BuildHeaderBarState();
}

class _BuildHeaderBarState extends State<BuildHeaderBar> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: context.width * 0.1,
              height: context.width * 0.1,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colours.lightThemeGreen5,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colours.lightThemeBlack1.withAlpha(70),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: SvgPicture.asset(Media.categoryArrow),
              ),
            ),
          ),

          // Title
          Text(
            'Pizza Varities',
            style: TextStyles.textSemiBoldLarge.white1,
          ),

          // Favorite button
          Container(
            width: context.width * 0.1,
            height: context.width * 0.1,
            decoration: BoxDecoration(
              color: Colours.lightThemeGreen5,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colours.lightThemeBlack1.withAlpha(70),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(
                isFavorited
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: Colours.lightThemeWhite1,
                size: context.width * 0.06,
              ),
              onPressed: () {
                setState(() {
                  isFavorited = !isFavorited;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
