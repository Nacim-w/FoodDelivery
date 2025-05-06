import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/features/dish/pizza/presentation/app/pizza_details_provider.dart';
import 'package:provider/provider.dart';

class PizzaCarousel extends StatelessWidget {
  const PizzaCarousel({super.key});

  double _getScale(String size) => {'S': 0.4, 'M': 0.5, 'L': 0.6}[size] ?? 0.6;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PizzaDetailsProvider>();
    final pizzaImages = [
      Media.pizza1,
      Media.pizza2,
      Media.pizza3,
      Media.pizza4,
    ];

    return Positioned(
      top: context.height * 0.18,
      child: SizedBox(
        width: context.width,
        height: context.width * 0.8,
        child: PageView.builder(
          controller: provider.pageController,
          itemCount: pizzaImages.length,
          onPageChanged: provider.setSelectedPizzaIndex,
          itemBuilder: (context, index) {
            final scale = _getScale(provider.selectedSize);
            return Center(
              child: AnimatedRotation(
                duration: const Duration(milliseconds: 400),
                turns: provider.rotationAngle,
                curve: Curves.easeInOut,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  width: context.width * scale,
                  height: context.width * scale,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(pizzaImages[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
