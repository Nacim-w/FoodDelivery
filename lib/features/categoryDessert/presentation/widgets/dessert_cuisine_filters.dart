import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class DessertCuisine {
  final String label;
  final String iconPath;

  DessertCuisine({required this.label, required this.iconPath});
}

class DessertCuisineFilters extends StatefulWidget {
  const DessertCuisineFilters({super.key});

  @override
  State<DessertCuisineFilters> createState() => _DessertCuisineFiltersState();
}

class _DessertCuisineFiltersState extends State<DessertCuisineFilters> {
  final List<DessertCuisine> cuisines = [
    DessertCuisine(label: 'Cake', iconPath: Media.dessertIcon1),
    DessertCuisine(label: 'Donuts', iconPath: Media.dessertIcon3),
    DessertCuisine(label: 'Cookies', iconPath: Media.dessertIcon2),
  ];

  String selectedCuisine = 'Cake';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.width * 0.15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cuisines.length,
        itemBuilder: (context, index) {
          final cuisine = cuisines[index];
          final isSelected = cuisine.label == selectedCuisine;

          return Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Center(
              child: Material(
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedCuisine = cuisine.label;
                    });
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colours.lightThemeBrown5
                          : Colours.lightThemeWhite1,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colours.lightThemeBlack0.withAlpha(90),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          cuisine.iconPath,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            isSelected
                                ? Colors.white
                                : Colours.lightThemeBrown5,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          cuisine.label,
                          style: TextStyles.textSemiBold.copyWith(
                            color: isSelected
                                ? Colors.white
                                : Colours.lightThemeBrown5,
                          ),
                        ),
                      ],
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
