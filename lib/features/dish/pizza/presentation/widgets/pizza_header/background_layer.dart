import 'package:flutter/material.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_header/build_header_bar.dart';

class BackgroundLayer extends StatelessWidget {
  const BackgroundLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colours.lightThemeBlack0,
          width: context.width,
          height: context.height,
          child: Column(
            children: [
              context.adaptiveGap,
              BuildHeaderBar(),
            ],
          ),
        ),
      ],
    );
  }
}
