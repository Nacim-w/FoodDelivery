import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/cart/presentation/views/full_cart_view.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/search/presentation/view/search_view.dart';

class _AnimatedSearchBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final GlobalKey<ScaffoldState> scaffoldKey;

  _AnimatedSearchBarHeaderDelegate({required this.scaffoldKey});

  final double _maxExtent = 80;
  final double _minExtent = 60;

  @override
  double get minExtent => _minExtent;
  @override
  double get maxExtent => _maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double progress =
        (shrinkOffset / (_maxExtent - _minExtent)).clamp(0.0, 1.0);
    final double fullWidth = MediaQuery.of(context).size.width;
    final double searchBarWidth =
        lerpDouble(fullWidth - 80, fullWidth * 0.6, progress)!;

    return Container(
      color: Colours.lightThemeOrange0,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (progress == 1.0)
            Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: SvgPicture.asset(
                  Media.sidebar,
                  width: 18,
                  height: 18,
                  colorFilter: const ColorFilter.mode(
                    Colours.lightThemeWhite1,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            )
          else
            const Spacer(),

          const Gap(8),

          // Centered Search Bar with dynamic width
          SizedBox(
            width: searchBarWidth,
            height: 44,
            child: Hero(
              tag: 'searchBarHero',
              child: Material(
                color: Colours.lightThemeOrange5,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () => context.push(SearchView.routePath),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colours.lightThemeGrey1,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search,
                            color: Colours.lightThemeOrange0),
                        const Gap(10),
                        Expanded(
                          child: TextField(
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Rechercher un plat ou un restaurant',
                              hintStyle: TextStyles.textMediumSmall.copyWith(
                                overflow: TextOverflow.ellipsis,
                              ),
                              border: InputBorder.none,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          const Gap(8),

          // RIGHT: Cart SVG icon or Spacer
          if (progress == 1.0)
            IconButton(
              onPressed: () {
                context.push('${HomePage.routePath}/${FullCartView.routePath}');
              },
              icon: SvgPicture.asset(
                Media.cart,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Colours.lightThemeWhite1,
                  BlendMode.srcIn,
                ),
              ),
            )
          else
            const Spacer(),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
