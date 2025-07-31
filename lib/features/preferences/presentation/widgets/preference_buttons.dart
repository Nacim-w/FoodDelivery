import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';

class PreferencesButtons extends StatelessWidget {
  final bool canProceed;
  final VoidCallback onPass;

  const PreferencesButtons({
    super.key,
    required this.canProceed,
    required this.onPass,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => context.go(HomePage.routePath),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colours.lightThemeGrey2,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Ignorer',
              style: TextStyles.textMediumLarge.black1,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: canProceed ? onPass : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colours.lightThemeOrange5,
              foregroundColor: Colours.lightThemeWhite1,
              disabledBackgroundColor: Colours.lightThemeOrange0.withAlpha(120),
              disabledForegroundColor: Colours.lightThemeWhite1,
            ),
            child: const Text('Passer'),
          ),
        ),
      ],
    );
  }
}
