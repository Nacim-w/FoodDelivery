import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/pizza/presentation/app/pizza_details_provider.dart';
import 'package:provider/provider.dart';

class PizzaTitleNumber extends StatefulWidget {
  const PizzaTitleNumber({super.key});

  @override
  State<PizzaTitleNumber> createState() => _PizzaTitleNumberState();
}

class _PizzaTitleNumberState extends State<PizzaTitleNumber> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PizzaDetailsProvider>();

    return Padding(
      padding:
          const EdgeInsets.only(left: 32.0, right: 32, top: 32, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Pizza',
            style: TextStyles.titleSemiBold.black1,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: Colours.lightThemeBrown5, width: 1.5),
                ),
                child: IconButton(
                  onPressed: provider.decrement,
                  icon: const Icon(Icons.remove),
                  color: Colours.lightThemeBrown5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  width: 20,
                  child: Center(
                    child: Text(
                      provider.quantity.toString(),
                      style: TextStyles.textMediumLargest.brown5,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: Colours.lightThemeBrown5, width: 1.5),
                ),
                child: IconButton(
                  onPressed: provider.increment,
                  icon: const Icon(Icons.add),
                  color: Colours.lightThemeBrown5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
