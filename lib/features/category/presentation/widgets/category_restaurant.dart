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

class CategoryRestaurant extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final String time;
  final String distance;
  final String rating;
  final Color accentColor;

  const CategoryRestaurant({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.time,
    required this.distance,
    required this.rating,
    required this.accentColor,
  });

  @override
  State<CategoryRestaurant> createState() => _CategoryRestaurantState();
}

class _CategoryRestaurantState extends State<CategoryRestaurant> {
  @override
  Widget build(BuildContext context) {
    final base64Str = widget.image.split(',').last;
    Uint8List imageBytes = base64Decode(base64Str);
    return Container(
      height: context.height * 0.115,
      decoration: BoxDecoration(
        color: Colours.lightThemeWhite4,
        boxShadow: [
          BoxShadow(
            color: Colours.lightThemeBlack1.withAlpha(25),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                height: context.height * 0.115,
                width: context.width * 0.25,
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
                  Gap(10),
                  Text(widget.title,
                      style: TextStyles.textSemiBoldSmall.brown5),
                  Gap(3),
                  SizedBox(
                    width: context.width * 0.48,
                    child: Text(
                      widget.description,
                      style: TextStyles.textSemiBoldTiny.black1,
                    ),
                  ),
                  Gap(5),
                  Row(
                    children: [
                      SvgPicture.asset(Media.homeClock),
                      Gap(3),
                      Text(widget.time,
                          style: TextStyles.textMediumSmall
                              .copyWith(color: widget.accentColor)),
                      Gap(28),
                      SvgPicture.asset(
                        Media.ratingStar,
                        colorFilter: ColorFilter.mode(
                            Colours.lightThemeYellow5, BlendMode.srcIn),
                      ),
                      Gap(3),
                      Text(widget.rating,
                          style: TextStyles.textMediumSmall
                              .copyWith(color: widget.accentColor)),
                      Gap(28),
                      SvgPicture.asset(Media.dot),
                      Gap(3),
                      Text('${widget.distance} km',
                          style: TextStyles.textMediumSmall
                              .copyWith(color: widget.accentColor)),
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
                color: widget.accentColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Center(child: SvgPicture.asset(Media.homeCamera)),
            ),
          ),
        ],
      ),
    );
  }
}
