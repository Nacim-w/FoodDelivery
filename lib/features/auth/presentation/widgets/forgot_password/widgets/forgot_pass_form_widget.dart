import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/auth_widgets.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/build_login_reg_widget.dart';
import 'package:legy/features/auth/presentation/views/otp_view.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildAutoSizeText(
          "Mot de passe oublié?",
        ),
        Text(
          "Saisissez votre e-mail pour recevoir un code de réinitialisation.",
          style: TextStyles.textMedium.grey1,
        ),
        Gap(20),
        Text("Adresse e-mail", style: TextStyles.textMedium),
        BuildTextField(
          hintText: "E-mail",
          textType: "email",
        ),
        Gap(MediaQuery.of(context).size.height * 0.16),
        BuildLogInAndRegButton(
          "Continue",
          "forgotPassword",
          () => context.go(OtpPage.routePath),
        )
      ],
    );
  }
}
