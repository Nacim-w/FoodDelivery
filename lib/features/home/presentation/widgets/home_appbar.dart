import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(
              builder: (context) => GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: SvgPicture.asset(
                  Media.sidebar,
                  width: 16,
                  height: 16,
                ),
              ),
            ),
            Row(
              children: [
                _iconCircleButton(Media.notificationBell),
                Gap(10),
                _iconCircleButton(Media.cart),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconCircleButton(String asset) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colours.lightThemeWhite1,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colours.lightThemeGrey2,
          width: 0.5,
        ),
      ),
      child: IconButton(
        onPressed: () {}, // Add your logic here
        icon: SvgPicture.asset(
          asset,
          width: 20,
          height: 20,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
