import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/common/routes/names.dart';
import 'package:testing/pages/auth/auth_widgets/auth_widgets.dart';

Widget goToLegal(Function()? func, String text, String type) {
  return GestureDetector(
    onTap: func,
    child: Text(text, style: TextStyles.textSemiBold.orange),
  );
}

Widget goToSignIn(Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Text("Se Connecter",
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
          style: TextStyles.textMedium.black,
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
      Text(
        "Vous avez un compte ? ",
        style: TextStyles.textMedium,
      ),
      goToSignIn(() => Navigator.of(context).pushNamed(AppRoutes.signIn)),
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
      Text(
        "Créez un compte pour commencer à chercher les plats que vous aimez.",
        style: TextStyles.textMedium.grey,
      ),
      Gap(
        10,
      ),
      Text(
        "Adresse e-mail",
        style: TextStyles.textMedium,
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
      Text(
        "Nom d'utilisateur",
        style: TextStyles.textMedium,
      ),
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
      Text(
        "Mot de passe",
        style: TextStyles.textMedium,
      ),
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
