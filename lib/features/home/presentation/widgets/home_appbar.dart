import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/home/presentation/widgets/appbar_icon.dart';
import 'package:legy/features/home/presentation/widgets/home_location.dart';
import 'package:legy/features/notification/presentation/view/notification_view.dart';
import 'package:legy/features/order/presentation/views/empty_cart_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

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
                  width: context.width * 0.03,
                  height: context.height * 0.03,
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
            Row(
              children: [
                AppbarIcon(
                  asset: Media.notificationBell,
                  func: () => context.go(
                      '${HomePage.routePath}/${NotificationView.routePath}'),
                ),
                const Gap(10),
                AppbarIcon(
                  asset: Media.cart,
                  func: () => context
                      .go('${HomePage.routePath}/${EmptyCart.routePath}'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
