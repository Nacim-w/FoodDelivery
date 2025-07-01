import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/widgets/rounded_button.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/auth/presentation/views/sign_in_view.dart';

class CustomModal extends StatelessWidget {
  const CustomModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.6,
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(10),
            Container(
              height: 4,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colours.lightThemeGrey1,
              ),
            ),
            Gap(30),
            Image.asset(Media.resetPasswordSuccess),
            const Gap(10),
            Text(
              "Mot de passe modifié",
              style: TextStyles.titleBold.black1,
            ),
            const Gap(10),
            Text(
              "Mot de passe modifié. Connectez-vous avec le nouveau.",
              style: TextStyles.textMedium.grey0,
              textAlign: TextAlign.center,
            ),
            const Gap(20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: RoundedButton(
                backgroundColour: Colours.lightThemeOrange5,
                text: "Vérifier le compte",
                onPressed: () => context.go(SignInPage.routePath),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showCustomModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
        child: Dialog(
          backgroundColor: Colors.white.withAlpha(220),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          insetPadding: EdgeInsets.only(top: context.height * 0.45),
          child: const CustomModal(),
        ),
      );
    },
  );
}
