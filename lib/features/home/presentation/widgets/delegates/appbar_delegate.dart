import 'package:flutter/material.dart';
import 'package:legy/features/home/presentation/widgets/home_appbar.dart';

class AnimatedHomeAppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 120;
  @override
  double get maxExtent => 120;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: HomeAppBar());
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
