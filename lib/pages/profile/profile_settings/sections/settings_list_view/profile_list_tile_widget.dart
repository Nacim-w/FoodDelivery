import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';

class BuildListTile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const BuildListTile({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colours.lightThemeBorderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        leading: SvgPicture.asset(
          width: 20,
          height: 20,
          icon,
        ),
        title: Text(title, style: TextStyles.textMedium.black),
        trailing: Icon(Icons.arrow_forward_ios_rounded,
            size: 16, color: Colours.lightThemeGreyArrowColor),
        onTap: onTap,
      ),
    );
  }
}
