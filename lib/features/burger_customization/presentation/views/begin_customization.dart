import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/burger_customization/presentation/widgets/suggestion_listview.dart';
import 'package:legy/features/burger_customization/presentation/widgets/middle_section.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';

class BeginCustomization extends StatefulWidget {
  const BeginCustomization({super.key});

  @override
  State<BeginCustomization> createState() => _BeginCustomizationState();
}

class _BeginCustomizationState extends State<BeginCustomization> {
  List<String> selectedIngredients = [];

  final Map<String, String> placedVersionMap = {
    Media.burgerBacon: Media.burgerPlacedBacon,
    Media.burgerCheese: Media.burgerPlacedCheese,
    Media.burgerLettuce: Media.burgerPlacedLettuce,
    Media.burgerPickles: Media.burgerPlacedPickle,
    Media.burgerMeat1: Media.burgerPlacedMeat,
    Media.burgerMeat2: Media.burgerPlacedMeat,
    Media.burgerMeat3: Media.burgerPlacedMeat,
    Media.burgerMeat4: Media.burgerPlacedMeat,
    Media.burgerBun2: Media.burgerPlacedTomato, // placeholder if needed
  };

  void addIngredient(String imagePath) {
    setState(() {
      if (imagePath.contains('burgerBun')) {
        selectedIngredients = [
          Media.burgerBottomBun,
          ...selectedIngredients,
          Media.burgerTopBun,
        ];
      } else {
        String placedImage = placedVersionMap[imagePath] ?? imagePath;
        if (selectedIngredients.isEmpty) {
          selectedIngredients.add(placedImage);
        } else {
          selectedIngredients.insert(
              selectedIngredients.length - 1, placedImage);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.lightThemeBlack0,
      body: Column(
        children: [
          if (selectedIngredients.isEmpty) ...[
            const SuggestionListview(),
            const Gap(20),
            const MiddleSection(),
          ],
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: context.width * 0.7,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    if (selectedIngredients.contains(Media.burgerBottomBun))
                      Positioned(
                        bottom: 0,
                        child: Image.asset(
                          Media.burgerBottomBun,
                          width: context.width * 0.7,
                        ),
                      ),
                    for (int i = 0; i < selectedIngredients.length; i++)
                      if (selectedIngredients[i] != Media.burgerBottomBun &&
                          selectedIngredients[i] != Media.burgerTopBun)
                        Positioned(
                          bottom: (i + 1) * 40,
                          child: Transform.scale(
                            scale: 1.0 - (i * 0.05),
                            child: Image.asset(
                              selectedIngredients[i],
                              width: context.width * 0.7,
                            ),
                          ),
                        ),
                    if (selectedIngredients.contains(Media.burgerTopBun))
                      Positioned(
                        bottom: selectedIngredients.length * 40 + 10,
                        child: Image.asset(
                          Media.burgerTopBun,
                          width: context.width * 0.7,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          BurgerChoices(
            onIngredientSelected: addIngredient,
          ),
        ],
      ),
    );
  }
}

class BurgerChoices extends StatefulWidget {
  final Function(String imagePath) onIngredientSelected;

  const BurgerChoices({
    super.key,
    required this.onIngredientSelected,
  });

  @override
  State<BurgerChoices> createState() => _BurgerChoicesState();
}

class _BurgerChoicesState extends State<BurgerChoices> {
  String selectedCategory = 'Pains';

  final Map<String, List<Map<String, String>>> choicesByCategory = {
    'Pains': [
      {'image': Media.burgerBun1, 'label': 'Pain classique'},
      {'image': Media.burgerBun2, 'label': 'Pain sésame'},
      {'image': Media.burgerBun3, 'label': 'Pain brioché'},
      {'image': Media.burgerBun4, 'label': 'Pain complet'},
      {'image': Media.burgerBun5, 'label': 'Pain keto'},
    ],
    'Galette': [
      {'image': Media.burgerMeat1, 'label': 'Boeuf classique'},
      {'image': Media.burgerMeat2, 'label': 'Poulet grillé'},
      {'image': Media.burgerMeat3, 'label': 'Double steak'},
      {'image': Media.burgerMeat4, 'label': 'Galette végétarienne'},
    ],
    'Garnitures': [
      {'image': Media.burgerCheese, 'label': 'Fromage'},
      {'image': Media.burgerBacon, 'label': 'Bacon'},
      {'image': Media.burgerPickles, 'label': 'Cornichons'},
      {'image': Media.burgerLettuce, 'label': 'Laitue'},
      {'image': Media.burgerPlacedTomato, 'label': 'Tomate'}, // placeholder
    ],
    'Sauces': [
      {'image': Media.burgerBun3, 'label': 'Ketchup'}, // placeholder
      {'image': Media.burgerBun4, 'label': 'Mayonnaise'}, // placeholder
      {'image': Media.burgerBun5, 'label': 'Barbecue'}, // placeholder
      {'image': Media.burgerBun1, 'label': 'Moutarde'}, // placeholder
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height * 0.25,
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colours.lightThemeWhite1,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: context.height * 0.12,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: choicesByCategory[selectedCategory]!
                  .map(
                      (item) => _ingredientItem(item['image']!, item['label']!))
                  .toList(),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: context.height * 0.06,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: choicesByCategory.keys
                  .map((category) => _categoryButton(category))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ingredientItem(String imagePath, String label) {
    return GestureDetector(
      onTap: () {
        widget.onIngredientSelected(imagePath);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            SizedBox(
              width: context.width * 0.18,
              height: context.height * 0.08,
              child: Image.asset(imagePath),
            ),
            Text(
              label,
              style: TextStyles.textMediumSmall.black1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryButton(String label) {
    final bool isSelected = selectedCategory == label;

    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            selectedCategory = label;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor:
              isSelected ? Colours.lightThemeOrange5 : Colors.transparent,
          side: BorderSide(color: Colours.lightThemeOrange5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          label,
          style: isSelected
              ? TextStyles.textMedium.white1
              : TextStyles.textMedium.orange5,
        ),
      ),
    );
  }
}
