import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/cart/presentation/views/full_cart_view.dart';
import 'package:legy/features/category/presentation/app/provider/category_provider.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';

class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CategoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => context.pop(),
            child: Container(
              width: context.width * 0.1,
              height: context.width * 0.1,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: context.watch<CategoryProvider>().color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colours.lightThemeBlack1.withAlpha(70),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2), // shadow position
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: SvgPicture.asset(
                  Media.categoryArrow,
                ),
              ),
            ),
          ),
          Text(
            'Catégorie',
            style: TextStyles.textBoldLarge.brown5,
          ),
          Container(
            width: context.width * 0.1,
            height: context.width * 0.1,
            decoration: BoxDecoration(
              color: context.watch<CategoryProvider>().color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colours.lightThemeBlack1.withAlpha(70),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  context
                      .push('${HomePage.routePath}/${FullCartView.routePath}');
                },
                icon: SvgPicture.asset(
                  Media.cart,
                  colorFilter: ColorFilter.mode(
                    Colours.lightThemeWhite1,
                    BlendMode.srcIn,
                  ),
                ),
                color: Colours.lightThemeWhite1,
                iconSize: context.width * 0.06,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
