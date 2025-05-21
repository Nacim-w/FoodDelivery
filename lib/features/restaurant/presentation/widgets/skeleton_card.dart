import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colours.lightThemeGrey2.withAlpha(100),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: context.height * 0.015,
                width: context.width * 0.3,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 6),
              Container(
                height: context.height * 0.015,
                width: context.width * 0.15,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
