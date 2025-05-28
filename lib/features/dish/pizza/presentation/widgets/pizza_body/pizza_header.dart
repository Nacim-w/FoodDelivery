import 'package:flutter/material.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_body/threed_page.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_header/background_layer.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_header/build_decoration.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_header/build_name_controls.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_header/pizza_carousel.dart';

class PizzaHeader extends StatefulWidget {
  const PizzaHeader({super.key});

  @override
  State<PizzaHeader> createState() => _PizzaHeaderState();
}

class _PizzaHeaderState extends State<PizzaHeader> {
  bool isFavorited = false;

  final List<String> pizzaImages = [
    Media.pizza1,
    Media.pizza2,
    Media.pizza3,
    Media.pizza4,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        BackgroundLayer(),
        const IgnorePointer(child: BuildDecoration()),
        PizzaCarousel(),
        BuildNameControls(),
        Positioned(
          top: 20,
          right: 20,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => My3DViewer()),
              );
            },
            icon: Icon(Icons.threed_rotation),
            label: Text("View 3D"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
