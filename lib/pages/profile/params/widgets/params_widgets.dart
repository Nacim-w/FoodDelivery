import 'package:flutter/material.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';

Widget buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 16, bottom: 8),
    child: Text(
      title,
      style: TextStyles.textSemiBold.black,
    ),
  );
}

Widget buildSwitchTile(String title, bool value, Function(bool) onChanged) {
  return SwitchListTile(
    title: Text(title, style: TextStyles.textMedium),
    value: value,
    onChanged: onChanged,
    inactiveThumbColor: Colors.white,
    inactiveTrackColor: Color(0xFFDFE0F3),
    activeColor: Colours.lightThemeOrangeTextColor,
  );
}

Widget buildListTile(String title, [String? subtitle]) {
  return ListTile(
    title: Text(title, style: TextStyles.textMedium),
    trailing: subtitle != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(subtitle, style: TextStyles.textMedium),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
            ],
          )
        : Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
    onTap: () {},
  );
}
