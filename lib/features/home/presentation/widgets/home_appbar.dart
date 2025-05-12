import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/home/presentation/widgets/home_location.dart';

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
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colours.lightThemeGrey0,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: const AssetImage(Media.homeAvatar),
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
