import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class RecentOrdersWidget extends StatefulWidget {
  const RecentOrdersWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.Description});
  final String image;
  final String title;
  final String Description;

  @override
  State<RecentOrdersWidget> createState() => _RecentOrdersWidgetState();
}

class _RecentOrdersWidgetState extends State<RecentOrdersWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(20),
        Container(
          height: context.height * 0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.image,
                  height: context.height * 0.08,
                  width: context.width * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.title,
                    style: TextStyles.textMediumLarge.black1,
                  ),
                  Text(
                    widget.Description,
                    style: TextStyles.textMediumSmall.grey1,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colours.lightThemeOrange5,
                        size: 18,
                      ),
                      Text(
                        "4.9",
                        style: TextStyles.textMediumSmall.black1,
                      ),
                      Gap(5),
                      SvgPicture.asset(Media.searchLocation),
                      Gap(5),
                      Text(
                        "190m",
                        style: TextStyles.textMediumSmall.black1,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
