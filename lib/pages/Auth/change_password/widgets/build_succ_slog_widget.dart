import 'package:flutter/material.dart';
import 'package:legy/common/extensions/text_style_extension.dart';
import 'package:legy/common/res/styles/text.dart';

class BuildSuccessSlogan extends StatelessWidget {
  final String slogan;

  const BuildSuccessSlogan(this.slogan, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      slogan,
      textAlign: TextAlign.center,
      style: TextStyles.textMedium.grey1,
    );
  }
}
