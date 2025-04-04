import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/common/routes/names.dart';
import 'package:testing/pages/profile/profile_settings/sections/logout/confirm_out_button_widget.dart';

class BuildBackdropFilter extends StatelessWidget {
  const BuildBackdropFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
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
          ConfirmOutButton(
            buttonName: "Annuler",
            buttonType: "annuler",
            func: () => Navigator.pop(context),
          ),
          ConfirmOutButton(
            buttonName: "Déconnexion",
            buttonType: "deconnexion",
            func: () => Navigator.of(context)
                .pushNamedAndRemoveUntil(AppRoutes.signIn, (route) => false),
          ),
        ],
      )
    ],
  );
}
