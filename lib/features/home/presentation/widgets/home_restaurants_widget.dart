import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      decoration: BoxDecoration(
        color: Color(0xFFFFF6F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyles.textMediumSmall.brown5),
                  Gap(5),
                  SizedBox(
                    width: 200,
                    child: AutoSizeText(
                      description,
                      style: TextStyles.textRegularTiny.black1,
                      maxLines: 3,
                    ),
                  ),
                  Gap(10),
                  Row(
                    children: [
                      SvgPicture.asset(Media.homeClock),
                      Gap(3),
                      Text(time, style: TextStyles.textMediumSmall.red5),
                      Gap(15),
                      SvgPicture.asset(Media.ratingStar),
                      Gap(3),
                      Text(rating, style: TextStyles.textMediumSmall.red5),
                      Gap(15),
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
