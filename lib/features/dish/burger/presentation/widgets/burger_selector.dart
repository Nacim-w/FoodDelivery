import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/burger/presentation/app/burger_details_provider.dart';
import 'package:provider/provider.dart';

class BurgerSelector extends StatelessWidget {
  const BurgerSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BurgerDetailsProvider>(context);
    final burgers = [
      {'name': 'Burger 1', 'image': Media.burger1},
      {'name': 'Burger 2', 'image': Media.burger2},
      {'name': 'Burger 3', 'image': Media.burger3},
      {'name': 'Burger 4', 'image': Media.burger4},
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.14,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: burgers.length,
        itemBuilder: (context, index) {
          final isSelected = provider.selectedBurgerIndex == index;

          return Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  provider.setSelectedBurgerIndex(index);
                  provider.pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.22,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colours.lightThemeOrange2
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
                        width: MediaQuery.of(context).size.width * 0.14,
                        height: MediaQuery.of(context).size.width * 0.14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(burgers[index]['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        burgers[index]['name']!,
                        style: TextStyles.textMediumSmall.black1,
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
