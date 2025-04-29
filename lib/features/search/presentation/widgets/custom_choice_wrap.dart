import 'package:flutter/material.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class CustomChoiceWrap<T> extends StatelessWidget {
  final List<T> options;
  final T? selectedOption;
  final Function(T) onSelected;
  final bool useIcon; // if you want an icon (for stars)

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
      spacing: 10,
      runSpacing: 10,
      children: options.map((option) {
        final isSelected = selectedOption == option;

        return ChoiceChip(
          showCheckmark: false,
          selected: isSelected,
          selectedColor: Colours.lightThemeOrange0,
          backgroundColor: Colours.lightThemeWhite2,
          label: useIcon
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, size: 18, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(option.toString()),
                  ],
                )
              : Text(option.toString()),
          labelStyle: isSelected
              ? TextStyles.textMedium.copyWith(color: Colors.white)
              : TextStyles.textMedium,
          onSelected: (_) => onSelected(option),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        );
      }).toList(),
    );
  }
}
