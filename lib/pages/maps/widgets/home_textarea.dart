import 'package:flutter/material.dart';
import 'package:legy/common/extensions/text_style_extension.dart';
import 'package:legy/common/res/styles/colours.dart';
import 'package:legy/common/res/styles/text.dart';

class HomeTextarea extends StatelessWidget {
  const HomeTextarea({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 5,
      decoration: InputDecoration(
        hintText:
            "tout autre détail pertinent pouvant aider à livrer avec précision un colis au destinataire prévu.",
        hintStyle: TextStyles.textRegularSmallest.grey2,
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
