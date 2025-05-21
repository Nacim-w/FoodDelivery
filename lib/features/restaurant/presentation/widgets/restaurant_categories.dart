import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/restaurant/model/restaurant_category_model.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_cubit.dart';

class RestaurantCategories extends StatelessWidget {
  final List<RestaurantCategoryModel> categories;

  const RestaurantCategories({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RestaurantCubit>().state;
    final selectedId = state.selectedCategoryId;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          final isSelected = cat.id == selectedId;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: OutlinedButton(
              onPressed: () {
                context.read<RestaurantCubit>().selectCategory(
                      state.selectedRestaurant!.id,
                      cat.id,
                    );
              },
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
