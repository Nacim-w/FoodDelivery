import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:legy/core/res/styles/colours.dart';

class AppbarIcon extends StatelessWidget {
  const AppbarIcon({super.key, required this.asset, required this.func});
  final String asset;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colours.lightThemeWhite1,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colours.lightThemeGrey2,
          width: 0.5,
        ),
      ),
      child: IconButton(
        onPressed: func,
        icon: SvgPicture.asset(
          asset,
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}
