import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/auth/presentation/views/sign_in_view.dart';

class SuggestLogin extends StatelessWidget {
  const SuggestLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Vous avez un compte ? ",
          style: TextStyles.textMedium,
        ),
        GestureDetector(
          onTap: () => context.go(SignInPage.routePath),
          child: Text(
            "Se Connecter",
            textAlign: TextAlign.right,
            style: TextStyles.textMedium.orange5,
          ),
        ),
      ],
    );
  }
}
