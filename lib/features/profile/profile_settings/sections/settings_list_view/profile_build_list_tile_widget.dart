import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class BuildListTile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;
  final Color? textColor;

  const BuildListTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
    this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: color ?? Colours.lightThemeGrey6),
          borderRadius: BorderRadius.circular(40),
        ),
        leading: SvgPicture.asset(
          width: 20,
          height: 20,
          icon,
          colorFilter: ColorFilter.mode(
            textColor ?? Colours.lightThemeGrey6,
            BlendMode.srcIn,
          ),
        ),
        title: Text(title,
            style: TextStyles.textMedium
                .copyWith(color: textColor ?? Colours.lightThemeGrey6)),
        trailing: Icon(Icons.arrow_forward_ios_rounded,
            size: 16, color: color ?? Colours.lightThemeGrey6),
        onTap: onTap,
      ),
    );
  }
}
