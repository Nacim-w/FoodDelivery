import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/features/coupons/presentation/views/coupon_view.dart';
import 'package:legy/features/dashboard/draw_item.dart';
import 'package:legy/features/home/model/home_profile_model.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/maps/map_page.dart';
import 'package:legy/features/cart/presentation/views/cart_view.dart';
import 'package:legy/features/payment/payment_page.dart';
import 'package:legy/features/profile/params/presentation/views/params_view.dart';
import 'package:legy/features/profile/profile_settings/profile_settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  HomeProfileModel? cachedProfile;

  @override
  void initState() {
    super.initState();
    _loadCachedProfile();
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView(
          children: [
            const Gap(30),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Gap(20),
                Image.asset(
                  Media.legyDrawer,
                  height: context.width * 0.3,
                  width: context.width * 0.5,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: const AssetImage(Media.profileAvatar),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cachedProfile?.firstname ?? 'Nom utilisateur',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        cachedProfile?.email ?? 'email@exemple.com',
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Gap(24.0),
            Text(
              'Général',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800),
            ),
            const SizedBox(height: 8.0),
            DrawerItem(
              leading: Media.profileDrawer,
              title: 'Mon compte',
              routing: ProfileSettingsPage.routePath,
            ),
            const SizedBox(height: 8.0),
            DrawerItem(
              leading: Media.orderDrawer,
              title: 'Mes commandes',
              routing: CartPage.routePath,
            ),
            const SizedBox(height: 8.0),
            DrawerItem(
                leading: Media.paymentDrawer,
                title: 'Paiement',
                routing: '${HomePage.routePath}/${PaymentPage.routePath}'),
            const SizedBox(height: 8.0),
            DrawerItem(
              leading: Media.locationDrawer,
              title: 'Adresses',
              routing: '${HomePage.routePath}/${MapPage.routePath}',
            ),
            const SizedBox(height: 8.0),
            DrawerItem(
              leading: Media.offreDrawer,
              title: 'Offres',
              routing: '${HomePage.routePath}/${CouponView.routePath}',
            ),
            const SizedBox(height: 8.0),
            DrawerItem(
              leading: Media.settingsDrawer,
              title: 'Paramètres',
              routing:
                  '${ProfileSettingsPage.routePath}/${ParamsView.routePath}',
            ),
          ],
        ),
      ),
    );
  }
}
