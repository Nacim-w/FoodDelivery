import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class PopularDish extends StatefulWidget {
  const PopularDish({super.key, required this.image});
  final String image;

  @override
  State<PopularDish> createState() => _PopularDishState();
}

class _PopularDishState extends State<PopularDish> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(60),
        Container(
          width: context.width * 0.35,
          height: context.height * 0.2,
          decoration: BoxDecoration(
              color: Colours.lightThemeWhite4,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colours.lightThemeBlack1.withAlpha(50),
                  blurRadius: 2,
                  spreadRadius: 0.1,
                ),
              ]),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: context.height * -0.05,
                left: context.width * 0.05,
                child: Container(
                  width: context.width * 0.25,
                  height: context.width * 0.25,

                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.image),
                      fit: BoxFit.cover
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(context.height * 0.08),
                  SizedBox(
                    width: context.width * 0.3,
                    child: AutoSizeText(
                      "Cheddar et coquilettes",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyles.textSemiBold.brown5,
                    ),
                  ),
                  Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Media.categoryScooter),
                      Gap(2),
                      Text(
                        '30mins',
                        style: TextStyles.textMediumSmall.brown5,
                      ),
                      Gap(2),
                      SvgPicture.asset(Media.categoryStar),
                      Gap(2),
                      Text(
                        '3.5',
                        style: TextStyles.textMediumSmall.brown5,
                      ),
                    ],
                  ),
                  Gap(8),
                  Text(
                    '40.50 CFA',
                    style: TextStyles.textMediumLarge.brown5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
