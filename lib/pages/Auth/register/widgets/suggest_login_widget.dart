import 'package:flutter/material.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/common/routes/names.dart';

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
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.signIn),
          child: Text(
            "Se Connecter",
            textAlign: TextAlign.right,
            style: TextStyles.textMedium.orange,
          ),
        ),
      ],
    );
  }
}
