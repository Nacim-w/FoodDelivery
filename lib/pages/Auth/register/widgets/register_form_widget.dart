import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/pages/auth/auth_widgets/auth_widgets.dart';
import 'package:testing/pages/auth/register/widgets/checkbox_widget.dart';
import 'package:testing/pages/auth/register/widgets/confidential_text_widget.dart';
import 'package:testing/pages/auth/register/widgets/suggest_login_widget.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool isChecked = false;

  void handleCheckboxChange(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        BuildTextField(
          hintText: "Ecivez votre adresse e-mail",
          textType: "email",
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
        BuildTextField(
          hintText: "Ecivez votre nom d'utilisateur",
          textType: "email",
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
        BuildTextField(
          hintText: "Ecivez votre mot de passe",
          textType: "password",
        ),
        Row(
          children: [
            CheckboxWidget(
              isChecked: isChecked,
              handleCheckboxChange: handleCheckboxChange,
            ),
            ConfidentialText(),
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
        SuggestLogin(),
        Gap(
          40,
        ),
      ],
    );
  }
}
