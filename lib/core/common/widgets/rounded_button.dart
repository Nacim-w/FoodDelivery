import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.text,
    super.key,
    this.onPressed,
    this.height,
    this.width,
    this.padding,
    this.textStyle,
    this.backgroundColour,
    this.foregroundColour,
    this.widgetContentButton,
    this.isMultipleButtonSelection = false,
  });

  final VoidCallback? onPressed;
  final String text;
  final Widget? widgetContentButton;
  final double? height;
  final double? width;
  final bool isMultipleButtonSelection;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Color? backgroundColour;
  final Color? foregroundColour;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48,
      width: width ?? double.maxFinite,
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45),
          ),
          side: isMultipleButtonSelection
              ? BorderSide(
                  width: 1,
                  color: Colours.lightThemeOrange5,
                )
              : BorderSide.none,
          foregroundColor: foregroundColour,
          backgroundColor: backgroundColour,
          padding: padding,
        ),
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          onPressed?.call();
        },
        child: text.isNotEmpty
            ? Text(
                text,
                style: textStyle ?? TextStyles.textSemiBoldLargest.white1,
              )
            : widgetContentButton,
      ),
    );
  }
}
