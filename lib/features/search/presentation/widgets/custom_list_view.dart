import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class CustomListView<T> extends StatelessWidget {
  final List<T> options;
  final T? selectedOption;
  final Function(T) onSelected;
  const CustomListView({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: options.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final option = options[index];
          final isSelected = selectedOption == option;

          return ChoiceChip(
            showCheckmark: false,
            selected: isSelected,
            selectedColor: Colours.lightThemeOrange5,
            backgroundColor: Colours.lightThemeWhite2,
            label: Text(option.toString()),
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
        },
      ),
    );
  }
}
