import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class CustomChoiceWrap<T> extends StatelessWidget {
  final List<T> options;
  final T? selectedOption;
  final Function(T) onSelected;
  final bool useIcon;

  const CustomChoiceWrap({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onSelected,
    this.useIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: options.map((option) {
        final isSelected = selectedOption == option;

        return ChoiceChip(
          showCheckmark: false,
          selected: isSelected,
          selectedColor: Colours.lightThemeOrange5,
          backgroundColor: Colours.lightThemeWhite2,
          label: useIcon
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star,
                        size: 18, color: Colours.lightThemeYellow5),
                    const SizedBox(width: 4),
                    Text(option.toString()),
                  ],
                )
              : Text(option.toString()),
          labelStyle: isSelected
              ? TextStyles.textSemiBoldLarge.white1
              : TextStyles.textMediumLarge.grey1,
          onSelected: (_) => onSelected(option),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: isSelected
                  ? Colours.lightThemeOrange5
                  : Colours.lightThemeGrey1,
              width: 0.2,
            ),
          ),
        );
      }).toList(),
    );
  }
}
