import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/features/burger_customization/presentation/widgets/burger_suggestion.dart';

class SuggestionListview extends StatefulWidget {
  const SuggestionListview({super.key});

  @override
  State<SuggestionListview> createState() => _SuggestionListviewState();
}

class _SuggestionListviewState extends State<SuggestionListview> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.2,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        scrollDirection: Axis.horizontal,
        children: const [
          BurgerSuggestion(
            picture: Media.burger1,
            name: "Le Fromager",
            description: "3 fromages fondus",
            price: "239.00 CFA",
          ),
          SizedBox(width: 16),
          BurgerSuggestion(
            picture: Media.burger2,
            name: "Le Fromager",
            description: "3 fromages fondus",
            price: "239.00 CFA",
          ),
          SizedBox(width: 16),
          BurgerSuggestion(
            picture: Media.burger3,
            name: "Le Fromager",
            description: "3 fromages fondus",
            price: "239.00 CFA",
          ),
          SizedBox(width: 16),
          BurgerSuggestion(
            picture: Media.burger4,
            name: "Le Fromager",
            description: "3 fromages fondus",
            price: "239.00 CFA",
          ),
        ],
      ),
    );
  }
}
