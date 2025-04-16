import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:legy/common/extensions/text_style_extension.dart';
import 'package:legy/common/res/styles/text.dart';

class ConfidentialText extends StatelessWidget {
  const ConfidentialText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "J'accepte ",
              style: TextStyles.textMedium.black2,
            ),
            TextSpan(
              text: "Les Conditions d'Utilisation",
              style: TextStyles.textMedium.orange5,
              recognizer: TapGestureRecognizer()..onTap = () => {},
            ),
            TextSpan(
              text: " et ",
              style: TextStyles.textMedium.black2,
            ),
            TextSpan(
              text: "Politique de Confidentialité",
              style: TextStyles.textMedium.orange5,
              recognizer: TapGestureRecognizer()..onTap = () => {},
            ),
          ],
        ),
      ),
    );
  }
}
