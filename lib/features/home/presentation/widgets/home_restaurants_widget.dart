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

class HomeRestaurants extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String time;
  final String distance;
  final String rating;

  const HomeRestaurants(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.time,
      required this.distance,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    final base64Str = image.split(',').last;
    Uint8List imageBytes = base64Decode(base64Str);
    return Container(
      height: context.height * 0.115,
      width: context.width * 0.95,
      decoration: BoxDecoration(
        color: Colours.lightThemeWhite4,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colours.lightThemeBlack1.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            children: [
              Container(
                height: context.width * 0.23,
                width: context.width * 0.23,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: MemoryImage(imageBytes),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Gap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(8),
                  Text(title, style: TextStyles.textSemiBoldSmall.brown5),
                  Gap(5),
                  SizedBox(
                    width: context.width * 0.48,
                    height: context.height * 0.04,
                    child: Text(
                      description,
                      style: TextStyles.textSemiBoldTiny.grey5,
                    ),
                  ),
                  Gap(5),
                  Row(
                    children: [
                      SvgPicture.asset(Media.homeClock),
                      Gap(3),
                      Text(time, style: TextStyles.textMediumSmall.red5),
                      Gap(32),
                      SvgPicture.asset(Media.ratingStar,
                          colorFilter: ColorFilter.mode(
                              Colours.lightThemeYellow0, BlendMode.srcIn)),
                      Gap(3),
                      Text(rating, style: TextStyles.textMediumSmall.red5),
                      Gap(32),
                      SvgPicture.asset(Media.dot),
                      Gap(3),
                      Text(distance, style: TextStyles.textMediumSmall.red5),
                    ],
                  ),
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
                color: Colours.lightThemeRed5,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(Media.homeCamera),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
