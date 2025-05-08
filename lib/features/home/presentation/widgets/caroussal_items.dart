import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class CaroussalItems extends StatelessWidget {
  const CaroussalItems({
    super.key,
    required this.image,
    required this.title,
    required this.body,
    required this.buttonName,
  });

  final String image;
  final String title;
  final String body;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: context.height * 0.35,
        width: context.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(60),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Burger image behind content
            Positioned(
              right: -10,
              top: 10,
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  image,
                  width: context.width * 0.6,
                  height: context.height * 0.35,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // Content
            Positioned(
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: context.width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyles.textRegularSmallest.black1),
                      Gap(10),
                      AutoSizeText(
                        body,
                        style: TextStyles.textBold.black1,
                        maxLines: 3,
                      ),
                      Gap(10),
                      Container(
                        width: context.width * 0.4,
                        height: context.height * 0.04,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colours.lightThemeGreen5,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          buttonName,
                          style: TextStyles.textSemiBoldSmall.white1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
