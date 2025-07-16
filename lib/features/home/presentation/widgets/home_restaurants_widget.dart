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
import 'package:panorama_viewer/panorama_viewer.dart';

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
      height: context.width * 0.26,
      width: context.width * 0.95,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 216, 216, 216).withAlpha(30),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colours.lightThemeBlack1.withAlpha(5),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            children: [
              Container(
                height: context.width * 0.26,
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
                  SizedBox(
                    width: context.width * 0.48,
                    child: Text(title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.textBoldSmall.brown5),
                  ),
                  Gap(5),
                  SizedBox(
                    width: context.width * 0.48,
                    height: context.height * 0.04,
                    child: Text(
                      maxLines: 2,
                      description,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.textSemiBoldSmall.grey5,
                    ),
                  ),
                  Spacer(),
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
                  Gap(10),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => showPanoramaDialog(context),
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
                child: Center(
                  child: SvgPicture.asset(Media.homeCamera),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showPanoramaDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withAlpha(200),
    builder: (context) => Stack(
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: 16 / 12,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: PanoramaViewer(
                animSpeed: 1.0,
                child: Image.asset(
                  'assets/images/360.jpg',
                  fit: BoxFit.cover, // keeps the image well scaled
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 40,
          right: 20,
          child: IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        )
      ],
    ),
  );
}
