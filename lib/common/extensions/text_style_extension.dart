import 'package:flutter/material.dart';
import 'package:testing/common/res/styles/colours.dart';

extension TextStyleExt on TextStyle {
  TextStyle get orange => copyWith(color: Colours.lightThemeOrangeTextColor);
  TextStyle get borderGrey => copyWith(color: Colours.lightThemeBorderColor);
  TextStyle get grey => copyWith(color: Colours.lightThemeSecondaryTextColor);
  TextStyle get black => copyWith(color: Colours.lightThemePrimaryTextColor);
  TextStyle get white => copyWith(color: Colours.lightThemePrimaryColor);
}
