import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class BuildHeaderBar extends StatefulWidget {
  const BuildHeaderBar({super.key});

  @override
  State<BuildHeaderBar> createState() => _BuildHeaderBarState();
}

class _BuildHeaderBarState extends State<BuildHeaderBar> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                color: Colours.lightThemeOrange0),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Text('Pizza Varities', style: TextStyles.textMediumLarge.white1),
          IconButton(
            icon: Icon(
              isFavorited
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: Colours.lightThemeOrange0,
            ),
            onPressed: () => setState(() => isFavorited = !isFavorited),
          ),
        ],
      ),
    );
  }
}
