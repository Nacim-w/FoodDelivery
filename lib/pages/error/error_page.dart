import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/common/extensions/text_style_extension.dart';
import 'package:legy/common/res/media.dart';
import 'package:legy/common/res/styles/text.dart';
import 'package:legy/pages/auth/auth_widgets/build_login_reg_widget.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Media.error,
        ),
        const Gap(20),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: AutoSizeText(
            textAlign: TextAlign.center,
            'Nous avons rencontré un problème, mais ne vous inquiétez pas !',
            style: TextStyles.titleSemiBold.black1,
            maxLines: 3,
          ),
        ),
        Gap(20),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: AutoSizeText(
            textAlign: TextAlign.center,
            'Please submit your email we will notify you',
            style: TextStyles.textMedium.black1,
            maxLines: 3,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: BuildLogInAndRegButton("Envoyer un e-mail", "null", () {})),
      ],
    ));
  }
}
