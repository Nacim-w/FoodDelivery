import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';

class BuildSuccessText extends StatelessWidget {
  final String text;

  const BuildSuccessText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      textAlign: TextAlign.center,
      style: TextStyles.titleBoldy.black1,
      maxLines: 2,
    );
  }
}
