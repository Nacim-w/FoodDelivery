import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class RestaurantProduct extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String time;
  final String distance;
  final String rating;

  const RestaurantProduct({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.time,
    required this.distance,
    required this.rating,
  });

  ImageProvider _getImageProvider() {
    if (image.isEmpty) {
      return const AssetImage(Media.recommandedProduct1);
    } else if (image.startsWith('http')) {
      return NetworkImage(image);
    } else if (image.startsWith('data:image')) {
      try {
        final base64Str = image.split(',').last;
        Uint8List imageBytes = base64Decode(base64Str);
        return MemoryImage(imageBytes);
      } catch (_) {
        return const AssetImage(Media.restaurant1);
      }
    } else {
      return const AssetImage(Media.restaurant1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.115,
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
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                height: context.width * 0.26,
                width: context.width * 0.23,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: _getImageProvider(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Gap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: context.width * 0.48,
                    child: Text(
                      title,
                      style: TextStyles.textBoldSmall.brown5,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const Gap(5),
                  Container(
                    width: context.width * 0.48,
                    height: context.height * 0.04,
                    child: Text(
                      description,
                      style: TextStyles.textSemiBoldSmall.grey5,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      SvgPicture.asset(Media.homeClock),
                      Gap(3),
                      Text(time, style: TextStyles.textMediumSmall.orange0),
                      Gap(32),
                      SvgPicture.asset(Media.ratingStar,
                          colorFilter: ColorFilter.mode(
                              Colours.lightThemeYellow0, BlendMode.srcIn)),
                      Gap(3),
                      Text(rating, style: TextStyles.textMediumSmall.orange0),
                      Gap(32),
                      SvgPicture.asset(Media.dot),
                      Gap(3),
                      Text(distance, style: TextStyles.textMediumSmall.orange0),
                    ],
                  ),
                  const Gap(15),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                color: Colours.lightThemeOrange5,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
