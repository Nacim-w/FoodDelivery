import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/search/presentation/widgets/custom_choice_wrap.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SearchSettingsSheet extends StatefulWidget {
  const SearchSettingsSheet({super.key});

  @override
  State<SearchSettingsSheet> createState() => _SearchSettingsSheetState();
}

class _SearchSettingsSheetState extends State<SearchSettingsSheet> {
  final List<String> categories = ["Sénégalaise", "Internationale", "Dessert"];
  final List<String> products = [
    "Pizza",
    "Burger",
    "Salade",
    "Soupe",
    "Poulet",
    "Grill",
    "Petit déjeuner"
  ];
  final List<int> stars = [1, 2, 3, 4, 5];

  String? selectedCategory = "Sénégalaise";
  String? selectedProduct = "Salade";
  int? selectedRating;
  RangeValues priceRange = const RangeValues(20, 40);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text("Filtres", style: TextStyles.textMediumLarge),
          ),
          const Gap(25),
          Text("Sélectionner les catégories", style: TextStyles.textMedium),
          const Gap(10),
          CustomChoiceWrap<String>(
            options: categories,
            selectedOption: selectedCategory,
            onSelected: (cat) => setState(() => selectedCategory = cat),
          ),
          const Gap(20),
          Text("Sélectionner le type de produit", style: TextStyles.textMedium),
          const Gap(10),
          CustomChoiceWrap<String>(
            options: products,
            selectedOption: selectedProduct,
            onSelected: (prod) => setState(() => selectedProduct = prod),
          ),
          const Gap(20),
          Text("Évaluation", style: TextStyles.textMedium),
          const Gap(10),
          CustomChoiceWrap<int>(
            options: stars,
            selectedOption: selectedRating,
            onSelected: (star) => setState(() => selectedRating = star),
            useIcon: true,
          ),
          const Gap(25),
          Text("Plage de prix", style: TextStyles.textMedium),
          SfRangeSlider(
            min: 10.0,
            max: 50.0,
            values: SfRangeValues(priceRange.start, priceRange.end),
            interval: 10,
            showLabels: true,
            activeColor: Colours.lightThemeYellow5,
            inactiveColor: Colours.lightThemeWhite2,
            onChanged: (SfRangeValues newValues) {
              setState(() {
                priceRange = RangeValues(newValues.start, newValues.end);
              });
            },
          ),
          Gap(25),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colours.lightThemeOrange0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                "Appliquer",
                style: TextStyles.textMediumLarge.white1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
