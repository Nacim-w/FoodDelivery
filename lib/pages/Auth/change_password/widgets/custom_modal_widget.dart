import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/common/res/media.dart';
import 'package:legy/common/routes/names.dart';
import 'package:legy/pages/auth/auth_widgets/build_login_reg_widget.dart';
import 'package:legy/pages/auth/change_password/widgets/build_succ_slog_widget.dart';
import 'package:legy/pages/auth/change_password/widgets/build_succ_txt_widget.dart';

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
                () => context.go(Routes.homePage),
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
