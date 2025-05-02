import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class IngredientsList extends StatelessWidget {
  const IngredientsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Ingrédients',
            style: TextStyles.titleSemiBoldTiny.black1,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.16,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width * 0.32,
              height: MediaQuery.of(context).size.height * 0.15,
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colours.lightThemeBlack1.withAlpha(20),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                  color: Colours.lightThemeWhite1,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage(Media.ingrediant),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text('Panner', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
