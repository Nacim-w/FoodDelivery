import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class ContinueButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback func;

  const ContinueButton({
    required this.buttonName,
    required this.func,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        width: context.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colours.lightThemeOrange5,
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        child: Center(
          child: Text(
            buttonName,
            textAlign: TextAlign.center,
            style: TextStyles.textSemiBold.white1,
          ),
        ),
      ),
    );
  }
}
