import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/pizza/presentation/app/pizza_details_provider.dart';
import 'package:provider/provider.dart';

class PizzaDrinkList extends StatelessWidget {
  const PizzaDrinkList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PizzaDetailsProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Boissons', style: TextStyles.titleSemiBoldTiny.black1),
        const SizedBox(height: 8),
        ...List.generate(provider.drinks.length, (index) {
          final drinks = provider.drinks[index];
          return Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(drinks['image']),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                drinks['name'],
                style: TextStyles.textMedium.orange5,
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '59 CFA',
                    style: TextStyles.textMedium.orange5,
                  ),
                  Checkbox(
                    value: drinks['selected'],
                    onChanged: (value) => provider.toggleDrinks(index, value!),
                    shape: CircleBorder(),
                    side: const BorderSide(
                        color: Colours.lightThemeOrange5, width: 2),
                    activeColor: Colours.lightThemeOrange5,
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
