import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/common/extensions/text_style_extension.dart';
import 'package:legy/common/res/styles/colours.dart';
import 'package:legy/common/res/styles/text.dart';

class SettingsCategorieWidget extends StatelessWidget {
  final String icon;
  final String text;

  const SettingsCategorieWidget(
      {super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: 30,
      decoration: BoxDecoration(
          color: Colours.lightThemeWhite1,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 0.5,
              blurRadius: 0.5,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 15,
            height: 15,
          ),
          Gap(10),
          Text(
            text,
            style: TextStyles.textMediumSmallest.black1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
