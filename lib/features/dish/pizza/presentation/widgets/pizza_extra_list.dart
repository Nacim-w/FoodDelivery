import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/pizza/presentation/app/pizza_details_provider.dart';
import 'package:provider/provider.dart';

class PizzaExtraList extends StatelessWidget {
  const PizzaExtraList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PizzaDetailsProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Extras', style: TextStyles.titleSemiBoldTiny.red5),
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
                    style: TextStyles.textMedium.orange5,
                  ),
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: extra['selected'],
                      onChanged: (value) => provider.toggleExtra(index, value!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      side: const BorderSide(
                        color: Colours.lightThemeOrange5,
                        width: 2,
                      ),
                      activeColor: Colours.lightThemeOrange5,
                    ),
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
