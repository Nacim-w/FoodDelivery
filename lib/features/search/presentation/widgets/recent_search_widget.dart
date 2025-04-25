import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class RecentSearchWidget extends StatelessWidget {
  final List<String> recentSearches; // List of recent searches
  final Function(String) onRemoveSearch; // Function to remove a specific search
  final Function() onClearAll; // Function to clear all searches

  const RecentSearchWidget(
      {super.key,
      required this.recentSearches,
      required this.onRemoveSearch,
      required this.onClearAll});

  @override
  Widget build(BuildContext context) {
    double height = (recentSearches.length * 30.0).toDouble();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recherches récentes",
              style: TextStyles.textMediumLarge,
            ),
            GestureDetector(
              onTap: onClearAll,
              child: Text(
                "Supprimer",
                style: TextStyles.textMedium.orange5,
              ),
            ),
          ],
        ),
        Gap(20),
        SizedBox(
          height: height < context.height * 0.3 ? height : context.height * 0.3,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: recentSearches.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.search, color: Colours.lightThemeGrey1),
                      Text(
                        recentSearches[index],
                        style: TextStyles.textMediumLarge,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => onRemoveSearch(
                      recentSearches[index],
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colours.lightThemeGrey1,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
