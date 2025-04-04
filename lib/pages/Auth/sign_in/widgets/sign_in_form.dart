import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/pages/auth/auth_widgets/auth_widgets.dart';
import 'package:testing/common/routes/names.dart';
import 'package:testing/pages/auth/sign_in/widgets/suggest_register_widget.dart';
import 'package:testing/pages/home/home_page.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
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
        BuildTextField(
          hintText: "Ecivez votre adresse e-mail",
          textType: "email",
        ),
        Gap(20),
        Text("Mot de passe", style: TextStyles.textMedium.black),
        Gap(5),
        BuildTextField(
          hintText: "Ecivez votre mot de passe",
          textType: "password",
        ),
        Gap(20),
        _forgotPassword(context),
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
        SuggestRegister(),
      ],
    );
  }
}

Widget _forgotPassword(BuildContext context) {
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
