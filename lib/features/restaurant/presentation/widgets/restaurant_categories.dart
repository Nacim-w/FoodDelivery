import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/restaurant/model/restaurant_category_model.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_product_provider.dart';
import 'package:provider/provider.dart';

class RestaurantCategories extends StatefulWidget {
  const RestaurantCategories({super.key, required this.categories});

  final List<RestaurantCategoryModel> categories;

  @override
  State<RestaurantCategories> createState() => _RestaurantCategoriesState();
}

class _RestaurantCategoriesState extends State<RestaurantCategories> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RestaurantProductProvider>();
    final selected = provider.selectedCategory;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.categories.map((cat) {
          final isSelected = selected == cat.name;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: OutlinedButton(
              onPressed: () => provider.changeCategory(cat.name),
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
                cat.name,
                style: isSelected
                    ? TextStyles.textMedium.white1
                    : TextStyles.textMedium.black1,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
