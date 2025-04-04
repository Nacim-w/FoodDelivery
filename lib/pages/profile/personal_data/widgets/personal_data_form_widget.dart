import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/pages/auth/auth_widgets/auth_widgets.dart';
import 'package:testing/pages/profile/personal_data/widgets/continue_button_widget.dart';
import 'package:testing/pages/profile/profile_settings/sections/profile_picture/profile_picture_widgets.dart';

class PersonalDataForm extends StatelessWidget {
  const PersonalDataForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: profilePictureStack(Media.profileAvatar),
        ),
        Gap(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nom complet",
              style: TextStyles.textMedium,
            ),
            Gap(8),
            BuildTextField(hintText: "Nom complet", textType: "email"),
            Gap(8),
            Text(
              "Date de naissance",
              style: TextStyles.textMedium,
            ),
            Gap(8),
            BuildTextField(hintText: "Date de naissance", textType: "email"),
            Gap(8),
            Text(
              "Genre",
              style: TextStyles.textMedium,
            ),
            Gap(8),
            BuildTextField(hintText: "Genre", textType: "sex"),
            Gap(8),
            Text("Téléphone"),
            Gap(8),
            BuildTextField(hintText: "Téléphone", textType: "email"),
            Gap(8),
            Text(
              "E-mail",
              style: TextStyles.textMedium,
            ),
            BuildTextField(hintText: "E-mail", textType: "email"),
            Gap(30),
            ContinueButton(buttonName: "Enregistrer", func: () {})
          ],
        ),
      ],
    );
  }
}
