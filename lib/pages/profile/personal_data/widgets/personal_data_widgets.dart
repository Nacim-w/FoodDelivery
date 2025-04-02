import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/pages/auth/auth_widgets/auth_widgets.dart';
import 'package:testing/pages/profile/profile_settings/sections/profile_picture/profile_picture_widgets.dart';

Widget personalDataForm(BuildContext context) {
  return Column(
    children: [
      Center(
        child: profilePictureStack(Media.profileAvatar),
      ),
      Gap(20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nom complet",
            style: TextStyles.textMedium,
          ),
          Gap(8),
          buildTextField("Nom complet", "email"),
          Gap(8),
          Text(
            "Date de naissance",
            style: TextStyles.textMedium,
          ),
          Gap(8),
          buildTextField("Date de naissance", "email"),
          Gap(8),
          Text(
            "Genre",
            style: TextStyles.textMedium,
          ),
          Gap(8),
          buildTextField("Genre", "sex"),
          Gap(8),
          Text("Téléphone"),
          Gap(8),
          buildTextField("Téléphone", "email"),
          Gap(8),
          Text(
            "E-mail",
            style: TextStyles.textMedium,
          ),
          Gap(8),
          buildTextField("E-mail", "email"),
          Gap(40),
          continueButton(context, "Enregistrer", "nothing", () {})
        ],
      ),
    ],
  );
}

Widget continueButton(BuildContext context, String buttonName,
    String buttonType, Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colours.lightThemeOrangeSecondaryTextColor,
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      child: Center(
        child: Text(
          buttonName,
          textAlign: TextAlign.center,
          style: TextStyles.textSemiBold.white,
        ),
      ),
    ),
  );
}
