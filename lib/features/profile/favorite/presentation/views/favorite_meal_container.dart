import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class FavoriteMealContainer extends StatelessWidget {
  final String image;
  final String name;
  final double rating;
  final double reviews;
  final double price;

  const FavoriteMealContainer({
    super.key,
    required this.image,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final base64Str = image.split(',').last;
    Uint8List imageBytes = base64Decode(base64Str);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: Colours.lightThemeGrey0,
          width: 0.2,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: context.height * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: MemoryImage(imageBytes),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Gap(5),
                Text(
                  name,
                  style: TextStyles.textBoldSmallest.black1,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 12,
                      color: Colours.lightThemeOrange5,
                    ),
                    Gap(5),
                    Text(
                      rating.toString(),
                      style: TextStyles.textMediumSmallest.black1,
                    ),
                    Gap(5),
                    Text(
                      // ignore: unnecessary_string_escapes
                      '($reviews\k)',
                      style: TextStyles.textMediumSmallest.black1,
                    ),
                  ],
                ),
                Text(
                  price.toInt().toString(),
                  style: TextStyles.textBoldSmallest.orange0,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 5,
            child: Container(
              width: context.width * 0.07,
              height: context.height * 0.07,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colours.lightThemeOrange0,
              ),
              child: Center(
                child: SvgPicture.asset(
                  Media.favoriteOrangy,
                  width: context.width * 0.035,
                  height: context.height * 0.02,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
