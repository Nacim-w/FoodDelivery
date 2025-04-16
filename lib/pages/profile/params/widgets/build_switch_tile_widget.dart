import 'package:flutter/material.dart';
import 'package:legy/common/res/styles/colours.dart';
import 'package:legy/common/res/styles/text.dart';

class BuildSwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const BuildSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title, style: TextStyles.textMedium),
      value: value,
      onChanged: onChanged,
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: Color(0xFFDFE0F3),
      activeColor: Colours.lightThemeOrange5,
    );
  }
}
