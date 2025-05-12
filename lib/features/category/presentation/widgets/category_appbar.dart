import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/category/presentation/app/provider/category_provider.dart';

class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CategoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => context.pop(),
            borderRadius: BorderRadius.circular(100),
            child: Container(
              width: context.width * 0.1,
              height: context.width * 0.1,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: context.watch<CategoryProvider>().color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colours.lightThemeGrey0,
                  width: 0.5,
                ),
              ),
              child: SvgPicture.asset(
                Media.arrowBack,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Media.homePin,
                  width: 18,
                  height: 18,
                  colorFilter: ColorFilter.mode(
                      Colours.lightThemeBlack1, BlendMode.srcIn)),
              Text("phnom penh, Cambodia",
                  style: TextStyle(color: Colors.black, fontSize: 14)),
              const Icon(Icons.keyboard_arrow_down,
                  size: 18, color: Colors.black),
            ],
          ),
          CircleAvatar(
            backgroundImage: AssetImage(Media.profileAvatar),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
