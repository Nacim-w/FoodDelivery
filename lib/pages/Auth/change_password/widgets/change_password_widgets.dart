import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/common/routes/names.dart';
import 'package:testing/common/widgets/common_widgets.dart';
import 'package:testing/pages/auth/auth_widgets/auth_widgets.dart';

Widget changePasswordForm(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildAutoSizeText("Réinitialiser le mot de passe"),
        buildSlogan(
            "Votre nouveau mot de passe doit être différent de l'ancien."),
        Gap(20),
        reusableText("Nouveau mot de passe"),
        Gap(5),
        buildTextField("Nouveau mot de passe", "password"),
        Gap(5),
        buildSlogan("Doit contenir au moins 8 caractères"),
        Gap(20),
        reusableText("Confirmer le mot de passe"),
        Gap(5),
        buildTextField("Confirmer le mot de passe", "password"),
        Gap(5),
        buildSlogan("Les deux mots de passe doivent correspondre."),
        Gap(MediaQuery.of(context).size.height * 0.25),
        buildLogInAndRegButton(context, "Changer mot de passe", "Verify",
            () => showCustomModal(context)),
      ],
    ),
  );
}

Widget buildAutoSizeTextSuccess(String text) {
  return AutoSizeText(
    text,
    textAlign: TextAlign.center,
    style: TextStyles.textBold.black,
    maxLines: 2,
  );
}

Widget buildSloganSucess(String slogan) {
  return Text(
    textAlign: TextAlign.center,
    slogan,
    style: TextStyles.textMedium.grey,
  );
}

void showCustomModal(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    showDragHandle: true,
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.68,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colours.lightThemePrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(Media.resetPasswordSuccess),
                Gap(10),
                buildAutoSizeTextSuccess("Mot de passe modifié"),
                Gap(10),
                buildSloganSucess(
                    "Mot de passe modifié. Connectez-vous avec le nouveau."),
                Gap(20),
                buildLogInAndRegButton(
                  context,
                  "Verify Account",
                  "verify",
                  () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.homePage, (route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
