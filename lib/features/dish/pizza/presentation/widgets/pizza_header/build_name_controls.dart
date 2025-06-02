import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/pizza/presentation/app/pizza_details_provider.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_body/threed_page.dart';
import 'package:provider/provider.dart';

class BuildNameControls extends StatelessWidget {
  const BuildNameControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.width * 1.15,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => My3DViewer(asset: Media.pizza3d),
                ),
              );
            },
            icon: const Icon(Icons.threed_rotation),
            color: Colours.lightThemeOrange5,
            style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colours.lightThemeWhite1,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colours.lightThemeOrange5,
                  width: 2,
                ),
              ),
            ),
          ),
          Spacer(),
          const SizedBox(width: 12), // spacing between icon and buttons
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
        padding: const EdgeInsets.all(14),
        backgroundColor:
            isSelected ? Colours.lightThemeOrange0 : Colors.transparent,
        side: BorderSide(
          color: Colours.lightThemeOrange0,
        ),
      ),
      child: Text(
        sizeLabel,
        style: TextStyles.textMediumLarge.white1.copyWith(
          color:
              isSelected ? Colours.lightThemeWhite1 : Colours.lightThemeOrange0,
        ),
      ),
    );
  }
}
