import 'package:flutter/material.dart';
import 'package:legy/features/home/presentation/widgets/home_appbar.dart';

class AnimatedHomeAppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 100;
  @override
  double get maxExtent => 100;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return HomeAppBar();
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
