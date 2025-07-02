import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class CurrentOrderWidget extends StatelessWidget {
  const CurrentOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colours.lightThemeRed5,
      padding: const EdgeInsets.all(16),
      radius: const Radius.circular(12),
      borderType: BorderType.RRect,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.asset(
                      Media.bestSeller,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 0,
                    child: Container(
                      width: 65,
                      height: 15,
                      decoration: const BoxDecoration(
                        color: Colours.lightThemeRed5,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(3.7),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Bestseller",
                          style: TextStyles.textRegularSmallest.white1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Biriyani au poulet",
                      style: TextStyles.textBoldLarge,
                    ),
                    Text(
                      "Gourmet Griddle - Mangalore ",
                      style: TextStyles.textRegularSmallest,
                    ),
                    /*Text(
                      "10 CFA",
                      style: TextStyles.textRegularLarge.orange5,
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        SvgPicture.asset(
                          Media.clock,
                          width: 15,
                          height: 15,
                        ),
                        const Gap(5),
                        Text("15 min", style: TextStyles.textSemiBoldSmallest),
                        const Gap(10),
                        Text(
                          "3 Km",
                          style: TextStyles.textSemiBoldSmallest
                              .copyWith(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    */
                  ],
                ),
              ),
            ],
          ),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: context.width * 0.4,
                  height: context.height * 0.05,
                  decoration: BoxDecoration(
                    color: Colours.lightThemeOrange5,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Text(
                      "Suivi",
                      style: TextStyles.textSemiBold.white1,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: context.width * 0.4,
                  height: context.height * 0.05,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colours.lightThemeOrange5,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Text(
                      "Racheter",
                      style: TextStyles.textSemiBold.orange5,
                    ),
                  ),
                ),
              ),
            ],
          ),*/
        ],
      ),
    );
  }
}
