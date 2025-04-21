import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class BuildSeperater extends StatelessWidget {
  const BuildSeperater({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: Divider(
            color: Colours.lightThemeGrey1,
            thickness: 0.5,
          ),
        ),
        Flexible(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Ou connectez-vous avec",
              style: TextStyles.textMedium.grey1,
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Divider(
            color: Colours.lightThemeGrey1,
            thickness: 0.5,
          ),
        ),
      ],
    );
  }
}
