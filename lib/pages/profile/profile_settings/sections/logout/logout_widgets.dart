import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/common/routes/names.dart';

Widget outbutton(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(16),
    child: OutlinedButton.icon(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return buildBackdropFilterDialog(context);
          },
        );
      },
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12),
        side: BorderSide(color: Colours.lightThemeBorderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      icon: Icon(Icons.logout, color: Colours.lightThemeOrangeTextColor),
      label: Text("Se déconnecter", style: TextStyles.textSemiBold.orange),
    ),
  );
}

Widget buildBackdropFilterDialog(BuildContext context) {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        width: 327,
        height: 184,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colours.lightThemePrimaryColor,
        ),
        child: content(context),
      ),
    ),
  );
}

Widget content(BuildContext context) {
  return Column(
    children: [
      Gap(8),
      Text(
        "Se déconnecter",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
      Gap(25),
      Text("Voulez-vous vous déconnecter ?", style: TextStyles.textMedium.grey),
      Gap(25),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          loggingOutButton(
              context, "Annuler", "annuler", () => Navigator.pop(context)),
          loggingOutButton(
            context,
            "Déconnexion",
            "deconnexion",
            () => Navigator.of(context)
                .pushNamedAndRemoveUntil(AppRoutes.signIn, (route) => false),
          ),
        ],
      )
    ],
  );
}

Widget loggingOutButton(BuildContext context, String buttonName,
    String buttonType, Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: MediaQuery.of(context).size.width / 3,
      height: 50,
      decoration: BoxDecoration(
        color: buttonType == "deconnexion"
            ? Colours.lightThemeOrangeTextColor
            : Colours.lightThemePrimaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
        border: Border.all(
          color: buttonType == "deconnexion"
              ? Colors.transparent
              : Colours.lightThemeBorderColor,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          buttonName,
          textAlign: TextAlign.center,
          style: buttonType == "deconnexion"
              ? TextStyles.textSemiBold.white
              : TextStyles.textSemiBold.black,
        ),
      ),
    ),
  );
}

Widget buildContinueButton(
  BuildContext context,
  String buttonName,
) {
  return GestureDetector(
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colours.lightThemeOrangeTextColor,
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
