import 'package:flutter/material.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/text.dart';

class ConfidentialText extends StatelessWidget {
  const ConfidentialText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Padding(
        padding: EdgeInsets.only(top: 25),
        child: RichText(
          text: TextSpan(
            style: TextStyles.textMedium.black,
            children: [
              TextSpan(
                text: "J'accepte ",
              ),
              WidgetSpan(
                child: _goToLegal(
                  () => {},
                  "Les Conditions d'Utilisation",
                  "con",
                ),
              ),
              TextSpan(
                text: " et ",
              ),
              WidgetSpan(
                child: _goToLegal(
                  () => {},
                  "Politique de Confidentialité",
                  "pol",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _goToLegal(Function()? func, String text, String type) {
  return GestureDetector(
    onTap: func,
    child: Text(text, style: TextStyles.textSemiBold.orange),
  );
}
