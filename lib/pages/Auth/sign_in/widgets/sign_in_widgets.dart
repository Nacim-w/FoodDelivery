import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/common/routes/names.dart';
import 'package:testing/pages/auth/auth_widgets/auth_widgets.dart';
import 'package:testing/pages/home/home_page.dart';

Widget forgotPassword(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.9,
    height: 44,
    child: GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.forgotPassword, (route) => false),
      child: Text(
        "Mot de passe oublié?",
        textAlign: TextAlign.right,
        style: TextStyles.textMedium.orange,
      ),
    ),
  );
}

Widget goToRegister(Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Text(
      "S'inscrire",
      textAlign: TextAlign.right,
      style: TextStyles.textMedium.orange,
    ),
  );
}

Widget suggestRegister(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Vous n'avez pas de compte ? ",
      ),
      goToRegister(
        () {
          Navigator.of(context).pushNamed(
            AppRoutes.register,
          );
        },
      ),
    ],
  );
}

Widget signInForm(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildAutoSizeText(
        'Connectez-vous à votre compte',
      ),
      Text(
        "Veuillez vous connecter à votre compte",
        style: TextStyles.textMedium.grey,
      ),
      Gap(40),
      Text("Adresse e-mail", style: TextStyles.textMedium.black),
      SizedBox(height: 5),
      buildTextField(
        "Ecivez votre adresse e-mail",
        "email",
      ),
      Gap(20),
      Text("Mot de passe", style: TextStyles.textMedium.black),
      Gap(5),
      buildTextField(
        "Ecivez votre mot de passe",
        "password",
      ),
      Gap(20),
      forgotPassword(context),
      buildLogInAndRegButton(
        context,
        "Se connecter",
        "login",
        () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        },
      ),
      Gap(20),
      buildSeperater(context),
      buildThirdPartyLogin(
        context,
      ),
      Gap(20),
      suggestRegister(context),
    ],
  );
}
