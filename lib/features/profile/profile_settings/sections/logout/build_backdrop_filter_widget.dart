import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/core/service/injection/injection_container.dart';
import 'package:legy/core/service/routing_service/router.dart';
import 'package:legy/features/profile/profile_settings/sections/logout/confirm_out_button_widget.dart';

class BuildBackdropFilter extends StatelessWidget {
  const BuildBackdropFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colours.lightThemeWhite1,
          ),
          child: content(context),
        ),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Column(
      children: [
        const Gap(8),
        const Text(
          "Se déconnecter",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const Gap(25),
        Text("Voulez-vous vous déconnecter ?",
            style: TextStyles.textMedium.grey1),
        const Gap(25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ConfirmOutButton(
              buttonName: "Annuler",
              buttonType: "annuler",
              func: () => Navigator.pop(context),
            ),
            ConfirmOutButton(
              buttonName: "Déconnexion",
              buttonType: "deconnexion",
              func: () async {

                Navigator.of(context).pop();
                await sl<CacheHelper>().resetSession();
                router.go('/');
              },
            ),
          ],
        )
      ],
    );
  }
}
