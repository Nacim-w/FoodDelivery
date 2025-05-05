import 'package:flutter/material.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/dish/burger/presentation/app/burger_details_provider.dart';
import 'package:provider/provider.dart';

class BurgerSelector extends StatelessWidget {
  const BurgerSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BurgerDetailsProvider>(context);
    final burgers = [
      {'name': 'Salade 1', 'image': Media.burger1},
      {'name': 'Salade 2', 'image': Media.burger2},
      {'name': 'Salade 3', 'image': Media.burger3},
      {'name': 'Salade 4', 'image': Media.burger4},
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.14,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: burgers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => provider.selectBurger(index),
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width * 0.22,
                  decoration: BoxDecoration(
                    color: Colours.lightThemeOrange1,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colours.lightThemeOrange0,
                      width: 1.0,
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
                            image:
                                AssetImage(burgers[index]['image'] as String),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        burgers[index]['name'] as String,
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
