import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class BlackAppBar extends StatelessWidget {
  const BlackAppBar({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
  });
  final String title;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: context.width * 0.1,
            height: context.width * 0.1,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color ?? Colours.lightThemeOrange5,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colours.lightThemeBlack1.withAlpha(70),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                Media.categoryArrow,
              ),
            ),
          ),
        ),
        Gap(20),
        Expanded(
          child: Center(
            child: Text(title, style: TextStyles.textBoldLarge.black1),
          ),
        ),
        SizedBox(width: context.width * 0.1),
      ],
    );
  }
}
