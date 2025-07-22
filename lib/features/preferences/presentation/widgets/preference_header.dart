import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';

class PreferencesHeader extends StatelessWidget {
  const PreferencesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Vos préférences culinaires ?',
            style: TextStyles.titleBoldLarge.black1),
        const Text(
          'Des idées repas selon vos goûts',
          style: TextStyles.titleRegularSmallest,
        ),
      ],
    );
  }
}
