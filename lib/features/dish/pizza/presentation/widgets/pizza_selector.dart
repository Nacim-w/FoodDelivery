import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/pizza/presentation/app/pizza_details_provider.dart';
import 'package:provider/provider.dart';

class PizzaSelector extends StatelessWidget {
  const PizzaSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PizzaDetailsProvider>(context);
    final pizzas = [
      {'name': 'Tomato', 'image': Media.pizza1},
      {'name': 'Italian', 'image': Media.pizza2},
      {'name': 'Bagel', 'image': Media.pizza3},
      {'name': 'Detroit', 'image': Media.pizza4},
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.14,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pizzas.length,
        itemBuilder: (context, index) {
          final isSelected = provider.selectedPizzaIndex == index;

          return Padding(
            padding: const EdgeInsets.all(4),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => provider.selectPizza(index),
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width * 0.22,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colours.lightThemeOrange1
                        : Colours.lightThemeOrange1.withAlpha(50),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isSelected
                          ? Colours.lightThemeOrange0
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.12,
                        height: MediaQuery.of(context).size.width * 0.12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(pizzas[index]['image'] as String),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        pizzas[index]['name'] as String,
                        style: TextStyles.textRegularSmall.black1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
