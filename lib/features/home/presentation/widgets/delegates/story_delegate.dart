import 'package:flutter/material.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/home/presentation/widgets/home_story_widget.dart';

class AnimatedHomeStoryDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 110;
  @override
  double get maxExtent => 120;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final opacity = 1.0 - (shrinkOffset / maxExtent).clamp(0.0, 1.0);
    return Opacity(
      opacity: opacity,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colours.lightThemeOrange0,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: HomeStoryWidget(),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
