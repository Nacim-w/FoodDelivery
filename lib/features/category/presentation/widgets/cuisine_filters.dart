import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class CuisineFilters extends StatefulWidget {
  const CuisineFilters({super.key});

  @override
  State<CuisineFilters> createState() => _CuisineFiltersState();
}

class _CuisineFiltersState extends State<CuisineFilters> {
  final List<String> cuisines = [
    'Italienne',
    'Japonaise',
    'Libanaise',
    'Mexicaine',
    'Indienne'
  ];
  String selectedCuisine = 'Italienne';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.width * 0.15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cuisines.length,
        itemBuilder: (context, index) {
          final cuisine = cuisines[index];
          final isSelected = cuisine == selectedCuisine;

          return Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Center(
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedCuisine = cuisine;
                    });
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colours.lightThemeOrange0
                          : Colours.lightThemeWhite1,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colours.lightThemeBlack0.withAlpha(90),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      cuisine,
                      style: TextStyles.textSemiBold.copyWith(
                        color: isSelected
                            ? Colors.white
                            : Colours.lightThemeBrown5,
                      ),
                    ),
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
