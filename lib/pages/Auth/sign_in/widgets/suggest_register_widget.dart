import 'package:flutter/material.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/common/routes/names.dart';

class SuggestRegister extends StatelessWidget {
  const SuggestRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Vous n'avez pas de compte ? ",
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.register,
            );
          },
          child: Text(
            "S'inscrire",
            textAlign: TextAlign.right,
            style: TextStyles.textMedium.orange,
          ),
        ),
      ],
    );
  }
}
