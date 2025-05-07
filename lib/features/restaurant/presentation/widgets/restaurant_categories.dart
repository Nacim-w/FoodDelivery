import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_product_provider.dart';
import 'package:provider/provider.dart';

class RestaurantCategories extends StatefulWidget {
  const RestaurantCategories({super.key});

  @override
  State<RestaurantCategories> createState() => _RestaurantCategoriesState();
}

class _RestaurantCategoriesState extends State<RestaurantCategories> {
  final categories = const ['Petit Déjeuner', 'pizzas', 'Plats'];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RestaurantProductProvider>();
    final selected = provider.selectedCategory;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((cat) {
        final isSelected = selected == cat;
        return OutlinedButton(
          onPressed: () =>
              context.read<RestaurantProductProvider>().changeCategory(cat),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colours.lightThemeOrange5),
            backgroundColor:
                isSelected ? Colours.lightThemeOrange5 : Colors.transparent,
            foregroundColor:
                isSelected ? Colors.white : Colours.lightThemeOrange5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            cat,
            style: isSelected
                ? TextStyles.textMedium.white1
                : TextStyles.textMedium.black1,
          ),
        );
      }).toList(),
    );
  }
}
