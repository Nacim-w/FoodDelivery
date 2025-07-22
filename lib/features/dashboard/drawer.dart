import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/cart/presentation/views/full_cart_view.dart';
import 'package:legy/features/coupons/presentation/views/coupon_view.dart';
import 'package:legy/features/home/model/home_profile_model.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/maps/presentation/view/map_view.dart';
import 'package:legy/features/payment/payment_page.dart';
import 'package:legy/features/profile/params/presentation/views/params_view.dart';
import 'package:legy/features/profile/profile_settings/profile_settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomHomeDrawer extends StatefulWidget {
  const CustomHomeDrawer({super.key});

  @override
  State<CustomHomeDrawer> createState() => _CustomHomeDrawerState();
}

class _CustomHomeDrawerState extends State<CustomHomeDrawer> {
  bool _isExpanded = false;
  HomeProfileModel? cachedProfile;

  @override
  void initState() {
    super.initState();
    _loadCachedProfile();
  }

  void toggleDrawer() {
    setState(() => _isExpanded = !_isExpanded);
  }

  void expandDrawer() {
    if (!_isExpanded) {
      setState(() => _isExpanded = true);
    }
  }

  Future<void> _loadCachedProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheHelper = CacheHelper(prefs);
    final profile = cacheHelper.getCachedUserProfile();

    if (mounted) {
      setState(() {
        cachedProfile = profile;
      });
    }
  }

  String capitalize(String? text) {
    if (text == null || text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }

  String getFormattedName() {
    final first = capitalize(cachedProfile?.firstname);
    final last = capitalize(cachedProfile?.lastname);
    final fullName = '$first $last'.trim();
    return fullName.isEmpty ? 'Nom utilisateur' : fullName;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onHorizontalDragStart: (_) => expandDrawer(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _isExpanded ? 300 : 72,
          decoration: BoxDecoration(
            color: Colours.lightThemeWhite1.withAlpha(230),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(120),
                blurRadius: 8,
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          context.adaptiveGap,
                          const Gap(40),
                          if (_isExpanded) ...[
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage(Media.profileAvatar),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getFormattedName(),
                                        style: TextStyles
                                            .textBoldLarge.drawerColor,
                                      ),
                                      const Gap(10),
                                      Text(
                                        cachedProfile?.email ??
                                            'email@exemple.com',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const Gap(35),
                            DottedLine(
                              dashLength: 6,
                              dashGapLength: 4,
                              lineThickness: 1.5,
                              dashColor: Colours.lightThemeOrange0,
                            ),
                            const Gap(35),
                          ],
                          _buildDrawerItem(
                            icon: Media.guestActive,
                            label: 'Mon compte',
                            onTap: () =>
                                context.push(ProfileSettingsPage.routePath),
                          ),
                          Gap(_isExpanded ? 20 : 40),
                          _buildDrawerItem(
                            icon: Media.orderDrawer,
                            label: 'Mes commandes',
                            onTap: () => context.push(
                              '${HomePage.routePath}/${FullCartView.routePath}',
                            ),
                          ),
                          Gap(_isExpanded ? 20 : 40),
                          _buildDrawerItem(
                            size: 16,
                            icon: Media.paymentDrawer,
                            label: 'Paiement',
                            onTap: () => context.push(
                              '${HomePage.routePath}/${PaymentPage.routePath}',
                            ),
                          ),
                          Gap(_isExpanded ? 20 : 40),
                          _buildDrawerItem(
                            icon: Media.locationDrawer,
                            label: 'Adresses',
                            onTap: () => context.push(
                              '${HomePage.routePath}/${MapView.routePath}',
                            ),
                          ),
                          Gap(_isExpanded ? 20 : 40),
                          _buildDrawerItem(
                            icon: Media.offreDrawer,
                            label: 'Offres',
                            onTap: () => context.push(
                                '${HomePage.routePath}/${CouponView.routePath}'),
                          ),
                          Gap(_isExpanded ? 20 : 40),
                          _buildDrawerItem(
                            icon: Media.settingsDrawer,
                            label: 'Paramètres',
                            onTap: () => context.push(
                              '${ProfileSettingsPage.routePath}/${ParamsView.routePath}',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String icon,
    required String label,
    required VoidCallback onTap,
    double? size,
  }) {
    return InkWell(
      onTap: () {
        if (_isExpanded) {
          Navigator.pop(context);
          WidgetsBinding.instance.addPostFrameCallback((_) => onTap());
        } else {
          expandDrawer();
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: size ?? 20,
              height: size ?? 20,
              colorFilter:
                  ColorFilter.mode(Colours.lightThemeBrown5, BlendMode.srcIn),
            ),
            if (_isExpanded) ...[
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyles.textMediumLarge.drawerColor,
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey.shade800,
                size: 25,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
