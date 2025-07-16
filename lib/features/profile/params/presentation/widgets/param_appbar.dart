import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class ParamAppbar extends StatelessWidget {
  const ParamAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => context.pop(),
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: context.width * 0.1,
            height: context.width * 0.1,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colours.lightThemeGreen5,
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
        Expanded(
          child: Center(
            child: Text('Paramètre', style: TextStyles.textBoldLarge.black1),
          ),
        ),
        SizedBox(width: context.width * 0.1),
      ],
    );
  }
}
