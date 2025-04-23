import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/build_login_reg_widget.dart';

import 'package:legy/features/auth/presentation/widgets/change_password/build_succ_slog_widget.dart';
import 'package:legy/features/auth/presentation/widgets/change_password/build_succ_txt_widget.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';

class CustomModal extends StatelessWidget {
  const CustomModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Media.resetPasswordSuccess),
            const Gap(10),
            BuildSuccessText("Mot de passe modifié"),
            const Gap(10),
            BuildSuccessSlogan(
                "Mot de passe modifié. Connectez-vous avec le nouveau."),
            const Gap(20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: BuildLogInAndRegButton(
                "Verify Account",
                "verify",
                () => context.go(HomePage.routePath),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showCustomModal(BuildContext context) {
  showModalBottomSheet(
    showDragHandle: true,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return const CustomModal();
    },
  );
}
