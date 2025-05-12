import 'package:auto_size_text/auto_size_text.dart';
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
                    image: AssetImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: TextStyles.textMediumSmall.brown5),
                  Gap(5),
                  SizedBox(
                    width: context.width * 0.55,
                    child: AutoSizeText(
                      widget.description,
                      style: TextStyles.textRegularTiny.black1,
                      maxLines: 3,
                    ),
                  ),
                  Gap(10),
                  Row(
                    children: [
                      SvgPicture.asset(Media.homeClock),
                      Gap(3),
                      Text(widget.time,
                          style: TextStyles.textMediumSmall
                              .copyWith(color: widget.accentColor)),
                      Gap(25),
                      SvgPicture.asset(
                        Media.ratingStar,
                        colorFilter: ColorFilter.mode(
                            Colours.lightThemeYellow5, BlendMode.srcIn),
                      ),
                      Gap(3),
                      Text(widget.rating,
                          style: TextStyles.textMediumSmall
                              .copyWith(color: widget.accentColor)),
                      Gap(20),
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
