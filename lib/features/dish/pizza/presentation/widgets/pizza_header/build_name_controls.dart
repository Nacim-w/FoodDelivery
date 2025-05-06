import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/pizza/presentation/app/pizza_details_provider.dart';
import 'package:provider/provider.dart';

class BuildNameControls extends StatelessWidget {
  const BuildNameControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.45,
      left: 16,
      right: 16,
      child: Row(
        children: [
          Text('Margherita', style: TextStyles.titleMediumSmall.white1),
          const Spacer(),
          ...['S', 'M', 'L'].map((size) => _buildSizeButton(context, size)),
        ],
      ),
    );
  }

  Widget _buildSizeButton(BuildContext context, String sizeLabel) {
    final provider = context.watch<PizzaDetailsProvider>();
    final bool isSelected = provider.selectedSize == sizeLabel;

    return OutlinedButton(
      onPressed: () => provider.setSize(sizeLabel),
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(18),
        backgroundColor:
            isSelected ? Colours.lightThemeOrange0 : Colors.transparent,
        side: BorderSide(
          color:
              isSelected ? Colours.lightThemeOrange0 : Colours.lightThemeWhite1,
        ),
        foregroundColor: Colours.lightThemeWhite1,
      ),
      child: Text(sizeLabel),
    );
  }
}
