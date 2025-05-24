import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';

class ProfileSettingsAppbar extends StatelessWidget {
  const ProfileSettingsAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (Navigator.canPop(context)) {
              context.pop();
            } else {
              context.go(
                  HomePage.routePath); // replace with your homepage route path
            }
          },
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: context.width * 0.1,
            height: context.width * 0.1,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colours.lightThemeWhite1,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colours.lightThemeGrey0,
                width: 0.2,
              ),
            ),
            child: SvgPicture.asset(
              Media.arrowBack,
              colorFilter: ColorFilter.mode(
                Colours.lightThemeBlack0,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text('Paramètres du profil',
                style: TextStyles.textMediumLarge.black1),
          ),
        ),
        SizedBox(width: context.width * 0.1),
      ],
    );
  }
}
