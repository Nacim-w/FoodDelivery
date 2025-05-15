import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';

class BuildDecoration extends StatelessWidget {
  const BuildDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: context.height * -0.3,
          right: context.width * -0.4,
          child: IgnorePointer(
            child: SvgPicture.asset(
              Media.bgLight,
              colorFilter: ColorFilter.mode(
                Colours.lightThemeYellow3.withAlpha(127),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        Positioned(
          top: context.width * -0.22,
          left: 0,
          child: Image(
            height: context.height * 0.95,
            width: context.width * 0.95,
            image: AssetImage(Media.pizzaDecoration),
          ),
        ),
        Positioned(
          top: context.width * -0.18,
          right: context.width * 0.05,
          child: Image(
            height: context.height * 0.85,
            width: context.width * 0.85,
            image: AssetImage(Media.woodenPlate),
          ),
        ),
      ],
    );
  }
}
