import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/auth/presentation/views/sign_up_View.dart';

class SuggestRegister extends StatelessWidget {
  const SuggestRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Vous n'avez pas de compte ? ",
          style: TextStyles.textMedium,
        ),
        GestureDetector(
          onTap: () => context.go(SignUpPage.routePath),
          child: Text(
            "S'inscrire",
            style: TextStyles.textMedium.orange5,
          ),
        ),
      ],
    );
  }
}
