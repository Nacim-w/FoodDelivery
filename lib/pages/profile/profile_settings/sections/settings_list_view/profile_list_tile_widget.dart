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
    return ListTile(
      leading: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Color(0xFFFEE1CF),
        ),
        child: Center(
          child: SvgPicture.asset(
            width: 15,
            height: 17,
            icon,
          ),
        ),
      ),
      title: Text(title, style: TextStyles.textMedium.black),
      trailing: Icon(Icons.arrow_forward_ios,
          size: 16, color: Colours.lightThemePrimaryTextColor),
      onTap: onTap,
    );
  }
}
