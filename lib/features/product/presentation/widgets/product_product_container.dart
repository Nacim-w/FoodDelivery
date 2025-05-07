import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class ProductProduct extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String time;
  final String distance;
  final String rating;

  const ProductProduct(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.time,
      required this.distance,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    /*final base64Str = image.split(',').last;
    Uint8List imageBytes = base64Decode(base64Str);*/
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
          ]),
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
                    //  image: MemoryImage(imageBytes),
                    image: AssetImage(Media.restaurant1),
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
                    width: context.width * 0.55,
                    child: AutoSizeText(
                      description,
                      style: TextStyles.textRegularTiny.black1,
                      maxLines: 3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(Media.homeClock),
                      Gap(5),
                      Text(time, style: TextStyles.textMediumSmall.red5),
                      Gap(20),
                      Icon(Icons.star,
                          color: Colours.lightThemeYellow5, size: 20),
                      Gap(5),
                      Text(rating, style: TextStyles.textMediumSmall.red5),
                      Gap(20),
                      SvgPicture.asset(Media.dot),
                      Gap(5),
                      Text(distance, style: TextStyles.textMediumSmall.red5),
                    ],
                  ),
                  Gap(15),
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
