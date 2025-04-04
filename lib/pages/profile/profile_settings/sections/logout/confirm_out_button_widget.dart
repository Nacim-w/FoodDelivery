import 'package:flutter/material.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';

class ConfirmOutButton extends StatelessWidget {
  final String buttonName;
  final String buttonType;
  final VoidCallback func;

  const ConfirmOutButton({
    super.key,
    required this.buttonName,
    required this.buttonType,
    required this.func,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        height: 50,
        decoration: BoxDecoration(
          color: buttonType == "deconnexion"
              ? Colours.lightThemeOrangeTextColor
              : Colours.lightThemePrimaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          border: Border.all(
            color: buttonType == "deconnexion"
                ? Colors.transparent
                : Colours.lightThemeBorderColor,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            buttonName,
            textAlign: TextAlign.center,
            style: buttonType == "deconnexion"
                ? TextStyles.textSemiBold.white
                : TextStyles.textSemiBold.black,
          ),
        ),
      ),
    );
  }
}
