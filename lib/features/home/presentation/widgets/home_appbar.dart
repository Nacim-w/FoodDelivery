import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/home/presentation/widgets/home_location.dart';
import 'package:legy/features/cart/presentation/views/full_cart_view.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.lightThemeOrange0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8).copyWith(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: SvgPicture.asset(
                  Media.sidebar,
                  width: 14,
                  height: 14,
                  colorFilter: ColorFilter.mode(
                    Colours.lightThemeWhite1,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: CurrentLocationButton(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    context.push(
                        '${HomePage.routePath}/${FullCartView.routePath}');
                  },
                  icon: SvgPicture.asset(
                    Media.cart,
                    colorFilter: ColorFilter.mode(
                      Colours.lightThemeWhite1,
                      BlendMode.srcIn,
                    ),
                  ),
                  iconSize: context.width * 0.06,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
