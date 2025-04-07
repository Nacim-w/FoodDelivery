import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/pages/auth/auth_widgets/auth_widgets.dart';
import 'package:testing/pages/auth/auth_widgets/build_login_reg_widget.dart';
import 'package:testing/pages/auth/change_password/widgets/custom_modal_widget.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAutoSizeText("Réinitialiser le mot de passe"),
          Text(
            "Votre nouveau mot de passe doit être différent de l'ancien.",
            style: TextStyles.textMedium.grey,
          ),
          const Gap(20),
          const Text("Nouveau mot de passe"),
          const Gap(5),
          BuildTextField(
              hintText: "Nouveau mot de passe", textType: "password"),
          const Gap(5),
          Text(
            "Doit contenir au moins 8 caractères",
            style: TextStyles.textMedium.grey,
          ),
          const Gap(20),
          Text(
            "Confirmer le mot de passe",
            style: TextStyles.textMedium,
          ),
          const Gap(5),
          BuildTextField(
              hintText: "Confirmer le mot de passe", textType: "password"),
          const Gap(5),
          Text(
            "Les deux mots de passe doivent correspondre.",
            style: TextStyles.textMedium.grey,
          ),
          Gap(MediaQuery.of(context).size.height * 0.20),
          BuildLogInAndRegButton(
              "Changer mot de passe", "Verify", () => showCustomModal(context)),
        ],
      ),
    );
  }
}
