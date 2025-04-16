import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/common/extensions/text_style_extension.dart';
import 'package:legy/common/res/media.dart';
import 'package:legy/common/res/styles/colours.dart';
import 'package:legy/common/res/styles/text.dart';

class ProfileAvatar extends StatelessWidget {
  final String name;
  final String email;

  const ProfileAvatar({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        profilePictureStack(Media.profileAvatar),
        Gap(10),
        Text(
          name.toUpperCase(),
          style: TextStyles.textMediumLarge.black1,
        ),
        Text(email, style: TextStyles.textMedium.grey1),
      ],
    );
  }
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
            color: Colours.lightThemeWhite3,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.camera_alt_rounded,
            color: Colours.lightThemeWhite3,
            size: 14,
          ),
        ),
      ),
    ],
  );
}
