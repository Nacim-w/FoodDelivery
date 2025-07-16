import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class ParamsTile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const ParamsTile({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colours.lightThemeWhite1,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colours.lightThemeGreen5),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          leading: SvgPicture.asset(
            width: 20,
            height: 20,
            icon,
            colorFilter: ColorFilter.mode(
              Colours.lightThemeGreen5,
              BlendMode.srcIn,
            ),
          ),
          title: Text(title, style: TextStyles.textMedium.black1),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Colours.lightThemeGreen5,
          ),
          onTap: onTap,
          horizontalTitleGap: 12,
        ),
      ),
    );
  }
}
