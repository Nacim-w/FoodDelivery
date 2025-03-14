import 'package:flutter/material.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/text.dart';

Widget forgotPassword(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.9,
    height: 44,
    child: GestureDetector(
      child: Text(
        "Mot de passe oublié?",
        textAlign: TextAlign.right,
        style: TextStyles.textMedium.orange,
      ),
      onTap: () {},
    ),
  );
}

Widget goToRegister(Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Text(
      "S'inscrire",
      textAlign: TextAlign.right,
      style: TextStyles.textMedium.orange,
    ),
  );
}
