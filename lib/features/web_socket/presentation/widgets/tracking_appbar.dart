import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';

class TrackingAppbar extends StatelessWidget {
  const TrackingAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Back Button
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: context.width * 0.1,
              height: context.width * 0.1,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colours.lightThemeOrange0,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colours.lightThemeBlack1.withAlpha(70),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: SvgPicture.asset(Media.categoryArrow),
              ),
            ),
          ),

          Text(
            'Tracking',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colours.lightThemeBlack1,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
