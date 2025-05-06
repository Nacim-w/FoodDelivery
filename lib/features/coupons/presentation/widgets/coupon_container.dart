import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class CouponContainer extends StatelessWidget {
  const CouponContainer(
      {super.key,
      required this.name,
      required this.discription,
      required this.couponCode});
  final String name;
  final String discription;
  final String couponCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: context.width * 0.9,
          height: context.height * 0.13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.width * 0.25,
                height: context.height * 0.13,
                decoration: BoxDecoration(
                  color: Colours.lightThemeYellow2,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SvgPicture.asset(
                    Media.discount,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyles.textBoldSmall.black1,
                    ),
                    SizedBox(
                      width: context.width * 0.6,
                      child: AutoSizeText(
                        discription,
                        style: TextStyles.textRegularSmallest.grey0,
                        maxLines: 2,
                      ),
                    ),
                    DottedBorder(
                      borderType: BorderType.RRect,
                      color: Colours.lightThemeGrey1,
                      radius: Radius.circular(7),
                      child: Row(
                        children: [
                          Text('Utiliser le code'),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colours.lightThemeYellow5,
                            ),
                            child: Text(couponCode,
                                style: TextStyles.textRegularSmall),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Gap(15),
      ],
    );
  }
}
