import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';

Widget profileAvatar(String name, String email) {
  return Column(
    children: [
      profilePictureStack(Media.profileAvatar),
      Gap(10),
      Text(
        name.toUpperCase(),
        style: TextStyles.textMediumLarge,
      ),
      Text(email, style: TextStyles.textMedium.grey),
    ],
  );
}

Widget profilePictureStack(String picture) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      ClipOval(
        child: Image.asset(
          picture,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        bottom: 0,
        left: 55,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colours.lightThemeWhiteIconColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.camera_alt_rounded,
            color: Colours.lightThemeOrangeTextColor,
            size: 14,
          ),
        ),
      ),
    ],
  );
}
