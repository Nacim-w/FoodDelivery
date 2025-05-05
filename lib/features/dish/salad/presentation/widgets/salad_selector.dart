import 'package:flutter/material.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/dish/salad/presentation/app/dish_details_provider.dart';
import 'package:provider/provider.dart';

class SaladSelector extends StatelessWidget {
  const SaladSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DishDetailsProvider>(context);
    final salads = [
      {'name': 'Salade 1', 'image': Media.salad1},
      {'name': 'Salade 2', 'image': Media.salad2},
      {'name': 'Salade 3', 'image': Media.salad3},
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: salads.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: Material(
              color: Colours.lightThemeGreen1,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => provider.selectSalad(index),
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
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
                            image: AssetImage(salads[index]['image'] as String),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        salads[index]['name'] as String,
                        style: const TextStyle(fontSize: 12),
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
