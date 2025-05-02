import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/presentation/app/dish_details_provider.dart';
import 'package:provider/provider.dart';

class ExtrasList extends StatelessWidget {
  const ExtrasList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DishDetailsProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Extra', style: TextStyles.titleSemiBoldTiny.black1),
        const SizedBox(height: 8),
        ...List.generate(provider.extras.length, (index) {
          final extra = provider.extras[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                extra['name'],
                style: TextStyles.textMedium.black1,
              ),
              Row(
                children: [
                  Text(
                    '59 CFA',
                    style: TextStyles.textMedium.green5,
                  ),
                  Checkbox(
                    value: extra['selected'],
                    onChanged: (value) => provider.toggleExtra(index, value!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: const BorderSide(
                        color: Colours.lightThemeGreen5, width: 2),
                    activeColor: Colours.lightThemeGreen5,
                  ),
                ],
              ),
            ],
          );
        }),
      ],
    );
  }
}
