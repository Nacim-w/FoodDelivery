import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/auth_widgets.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/build_login_reg_widget.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/build_seperator_widget.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/thirdparty_login_widget.dart';
import 'package:legy/features/auth/presentation/widgets/sign_up/checkbox_widget.dart';
import 'package:legy/features/auth/presentation/widgets/sign_up/confidential_text_widget.dart';
import 'package:legy/features/auth/presentation/widgets/sign_up/suggest_login_widget.dart';

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
          style: TextStyles.textMedium.grey1,
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
        Gap(20),
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
        BuildLogInAndRegButton("S'inscrire", "register", () {}),
        Gap(
          20,
        ),
        BuildSeperater(),
        BuildThirdPartyLogin(),
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
