import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/salad/presentation/app/salad_details_provider.dart';
import 'package:provider/provider.dart';

class SaladSelector extends StatelessWidget {
  const SaladSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SaladDetailsProvider>(context);

    final salads = [
      {'name': 'Salade 1', 'image': Media.salad1},
      {'name': 'Salade 2', 'image': Media.salad2},
      {'name': 'Salade 3', 'image': Media.salad3},
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.14,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: salads.length,
        itemBuilder: (context, index) {
          final isSelected = provider.selectedSaladIndex == index;

          return Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  provider.selectSalad(index);
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
                        ? Colours.lightThemeGreen3
                        : Colours.lightThemeGreen1.withAlpha(50),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isSelected
                          ? Colours.lightThemeGreen5
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
                            image: AssetImage(salads[index]['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        salads[index]['name']!,
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
