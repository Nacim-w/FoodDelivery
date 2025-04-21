import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class PaymentTextfield extends StatelessWidget {
  const PaymentTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyles.textSemiBold.black1,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colours.lightThemeGrey2),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Colours.lightThemeOrange5, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
