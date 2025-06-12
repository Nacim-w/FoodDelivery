import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/cart/presentation/views/full_cart_view.dart';
import 'package:legy/features/search/presentation/view/search_view.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.lightThemeOrange0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20)
            .copyWith(top: 40, bottom: 10),
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
            SizedBox(
              width: context.width * 0.6,
              height: 50,
              child: Hero(
                tag: 'searchBarHero',
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colours.lightThemeOrange5,
                  child: InkWell(
                    onTap: () => context.push(SearchView.routePath),
                    borderRadius: BorderRadius.circular(20),
                    child: IgnorePointer(
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colours.lightThemeWhite3,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10.0),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colours.lightThemeOrange0,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              Media.searchSettings,
                              colorFilter: const ColorFilter.mode(
                                Colours.lightThemeOrange0,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          hintText: "Rechercher dans Restaurants",
                          hintStyle: TextStyles.textMediumSmall.grey3,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colours.lightThemeGrey1,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colours.lightThemeOrange0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colours.lightThemeGrey1,
                            ),
                          ),
                        ),
                        style: TextStyles.textMediumSmall,
                      ),
                    ),
                  ),
                ),
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
                  iconSize: 14,
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
