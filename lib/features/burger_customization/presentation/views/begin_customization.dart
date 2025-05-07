import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/burger_customization/presentation/widgets/burger_choices.dart';
import 'package:legy/features/burger_customization/presentation/widgets/middle_section.dart';
import 'package:legy/features/burger_customization/presentation/widgets/suggestion_listview.dart';

class BeginCustomization extends StatefulWidget {
  const BeginCustomization({super.key});

  @override
  State<BeginCustomization> createState() => _BeginCustomizationState();
}

class _BeginCustomizationState extends State<BeginCustomization> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.lightThemeBlack0,
      body: SingleChildScrollView(
        // Wrap the Column inside a SingleChildScrollView
        child: Column(
          children: [
            const SuggestionListview(),
            const Gap(50),
            const MiddleSection(),
            const BurgerChoices(),
          ],
        ),
      ),
    );
  }
}
