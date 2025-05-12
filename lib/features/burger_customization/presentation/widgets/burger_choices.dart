import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class BurgerChoices extends StatefulWidget {
  const BurgerChoices({super.key});

  @override
  State<BurgerChoices> createState() => _BurgerChoicesState();
}

class _BurgerChoicesState extends State<BurgerChoices> {
  String selectedCategory = 'Pains';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height * 0.15,
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
            height: context.height * 0.14,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _bunItem(Media.bun1, "Pain classique"),
                _bunItem(Media.bun4, "Pain complet"),
                _bunItem(Media.bun3, "Pain brioché"),
                _bunItem(Media.bun2, "Pain sésame"),
                _bunItem(Media.bun5, "Pain keto"),
              ],
            ),
          ),
          SizedBox(
            height: context.height * 0.06,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _categoryButton('Pains'),
                _categoryButton('Galette'),
                _categoryButton('Garnitures'),
                _categoryButton('Sauces'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bunItem(String imagePath, String label) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: context.width * 0.25,
            height: context.height * 0.08,
            child: Image.asset(
              imagePath,
            ),
          ),
          Text(
            label,
            style: TextStyles.textMediumSmall.black1,
            textAlign: TextAlign.center,
          ),
        ],
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
