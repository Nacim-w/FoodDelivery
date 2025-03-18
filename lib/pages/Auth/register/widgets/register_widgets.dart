import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/common/routes/names.dart';
import 'package:testing/common/widgets/common_widgets.dart';
import 'package:testing/pages/Auth/auth_widgets/auth_widgets.dart';

Widget goToLegal(Function()? func, String text, String type) {
  return GestureDetector(
    onTap: func,
    child: Text(text, style: TextStyles.textSemiBold.orange),
  );
}

Widget goToSignIn(Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Text("S'inscrire",
        textAlign: TextAlign.right, style: TextStyles.textMedium.orange),
  );
}

Widget confidentialText() {
  return SizedBox(
    width: 280,
    child: Padding(
      padding: EdgeInsets.only(top: 25),
      child: RichText(
        text: TextSpan(
          style: TextStyles.textMedium,
          children: [
            TextSpan(
              text: "J'accepte ",
            ),
            WidgetSpan(
              child: goToLegal(
                () => {},
                "Les Conditions d'Utilisation",
                "con",
              ),
            ),
            TextSpan(
              text: " et ",
            ),
            WidgetSpan(
              child: goToLegal(
                () => {},
                "Politique de Confidentialité",
                "pol",
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildCheckBox(
  bool isChecked,
  void Function(bool?) handleCheckboxChange,
) {
  return Checkbox(
    side: BorderSide(
      color: Colours.lightThemePrimaryColor,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        5.0,
      ),
    ),
    fillColor: WidgetStateProperty.all(Colours.lightThemeOrangeTextColor),
    value: isChecked,
    onChanged: handleCheckboxChange,
  );
}

Widget suggestLogin(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      reusableText(
        "Vous n'avez pas de compte ? ",
      ),
      goToSignIn(() => Navigator.of(context).pushNamed(AppRoutes.register)),
    ],
  );
}

Widget registerForm(
    BuildContext context, bool isChecked, handleCheckboxChange) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildAutoSizeText(
        'Créez votre nouveau compte',
      ),
      buildSlogan(
        "Créez un compte pour commencer à chercher les plats que vous aimez.",
      ),
      Gap(
        10,
      ),
      reusableText(
        "Adresse e-mail",
      ),
      Gap(
        5,
      ),
      buildTextField(
        "Ecivez votre adresse e-mail",
        "email",
      ),
      Gap(
        20,
      ),
      reusableText("Nom d'utilisateur"),
      Gap(
        5,
      ),
      buildTextField(
        "Ecivez votre nom d'utilisateur",
        "email",
      ),
      Gap(
        20,
      ),
      reusableText("Mot de passe"),
      Gap(
        5,
      ),
      buildTextField(
        "Ecivez votre mot de passe",
        "password",
      ),
      Row(
        children: [
          buildCheckBox(isChecked, handleCheckboxChange),
          confidentialText(),
        ],
      ),
      Gap(
        20,
      ),
      buildLogInAndRegButton(context, "S'inscrire", "register", () {}),
      Gap(
        20,
      ),
      buildSeperater(context),
      buildThirdPartyLogin(context),
      Gap(
        20,
      ),
      suggestLogin(context),
      Gap(
        40,
      ),
    ],
  );
}
