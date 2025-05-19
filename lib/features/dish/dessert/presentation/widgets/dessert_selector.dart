import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/dessert/presentation/app/dessert_details_provider.dart';
import 'package:provider/provider.dart';

class DessertSelector extends StatelessWidget {
  const DessertSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DessertDetailsProvider>(context);
    final desserts = [
      {'name': 'Dessert 1', 'image': Media.dessert1},
      {'name': 'Dessert 2', 'image': Media.dessert2},
      {'name': 'Dessert 3', 'image': Media.dessert3},
      {'name': 'Dessert 4', 'image': Media.dessert4},
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.14,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 28),
        scrollDirection: Axis.horizontal,
        itemCount: desserts.length,
        itemBuilder: (context, index) {
          final isSelected = provider.selectedDessertIndex == index;

          return Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => provider.selectDessert(index),
              child: Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width * 0.22,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colours.lightThemeBrown2
                      : Colours.lightThemeBrown2.withAlpha(50),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isSelected
                        ? Colours.lightThemeBrown5
                        : Colors.transparent,
                    width: 1.2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      height: MediaQuery.of(context).size.width * 0.12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(desserts[index]['image'] as String),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      desserts[index]['name'] as String,
                      style: TextStyles.textMediumSmall.black1,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
