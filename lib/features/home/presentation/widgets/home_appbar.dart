import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/cart/presentation/views/cart_view.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/search/presentation/view/search_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _HomeAppBarState extends State<HomeAppBar> {
  bool _hasItemsInCart = false;

  @override
  void initState() {
    super.initState();
    _checkCart();
  }

  Future<void> _checkCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheHelper = CacheHelper(prefs);
    final cartItems = cacheHelper.getCartProducts();
    setState(() {
      _hasItemsInCart = cartItems.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.lightThemeOrange0,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: SvgPicture.asset(
                    Media.sidebar,
                    width: 14,
                    height: 14,
                    colorFilter: const ColorFilter.mode(
                      Colours.lightThemeWhite1,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: context.width * 0.65,
                height: 45,
                child: Hero(
                  tag: 'searchBarHero',
                  child: Material(
                    color: Colours.lightThemeOrange5,
                    borderRadius: BorderRadius.circular(99),
                    child: InkWell(
                      onTap: () => context.push(SearchView.routePath),
                      borderRadius: BorderRadius.circular(99),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: IgnorePointer(
                          child: TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colours.lightThemeWhite3,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colours.lightThemeOrange0,
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(14.0),
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
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            style: TextStyles.textMediumSmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      context
                          .push('${HomePage.routePath}/${CartView.routePath}');
                    },
                    icon: SvgPicture.asset(
                      Media.cart,
                      colorFilter: const ColorFilter.mode(
                        Colours.lightThemeWhite1,
                        BlendMode.srcIn,
                      ),
                    ),
                    iconSize: 14,
                  ),
                  if (_hasItemsInCart)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colours.lightThemeGreen5,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
