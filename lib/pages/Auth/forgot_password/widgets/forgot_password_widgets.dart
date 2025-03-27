import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/common/widgets/common_widgets.dart';
import 'package:testing/pages/auth/auth_widgets/auth_widgets.dart';
import 'package:testing/pages/auth/opt/otp_page.dart';

Widget goToLegal(Function()? func, String text, String type) {
  return GestureDetector(
    onTap: func,
    child: Text(text, style: TextStyles.textSemiBold.orange),
  );
}

Widget forgotPasswordForm(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildAutoSizeText(
        "Mot de passe oublié?",
      ),
      buildSlogan(
        "Saisissez votre e-mail pour recevoir un code de réinitialisation.",
      ),
      Gap(20),
      reusableText("Adresse e-mail"),
      buildTextField(
        "E-mail",
        "email",
      ),
      Gap(MediaQuery.of(context).size.height * 0.16),
      buildLogInAndRegButton(
        context,
        "Continue",
        "forgotPassword",
        () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => OtpPage(),
            ),
          );
        },
      )
    ],
  );
}
