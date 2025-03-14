import 'package:flutter/material.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/text.dart';

Widget goToLegal(Function()? func, String text, String type) {
  return GestureDetector(
    onTap: func,
    child: Text(text, style: TextStyles.textSemiBold.orange),
  );
}

Widget goToSignIn(Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Text("S'inscrire",
        textAlign: TextAlign.right, style: TextStyles.textMedium.orange),
  );
}
