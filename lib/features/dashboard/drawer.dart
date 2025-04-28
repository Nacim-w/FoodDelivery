import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/features/dashboard/draw_item.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/maps/map_page.dart';
import 'package:legy/features/order/presentation/views/full_cart_widget.dart';
import 'package:legy/features/order/order_page.dart';
import 'package:legy/features/profile/params/params_page.dart';
import 'package:legy/features/profile/profile_settings/profile_settings_page.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              Gap(30),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Image.asset(
                    Media.legyDrawer,
                    height: 24,
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
                        const Text(
                          'Mariama Sow',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Mariama.sow.example.com',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star,
                                  size: 16, color: Colors.orange),
                              const SizedBox(width: 4),
                              const Text(
                                'Premium',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
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
                  routing: '${HomePage.routePath}/${FullCart.routePath}'),
              const SizedBox(height: 8.0),
              DrawerItem(
                leading: Media.locationDrawer,
                title: 'Adresses',
                routing: '${HomePage.routePath}/${MapPage.routePath}',
              ),
              const SizedBox(height: 8.0),
              DrawerItem(
                leading: Media.subscriptionDrawer,
                title: 'Abonnement...',
                routing: ProfileSettingsPage.routePath,
              ),
              const SizedBox(height: 8.0),
              DrawerItem(
                leading: Media.settingsDrawer,
                title: 'Paramètres',
                routing:
                    '${ProfileSettingsPage.routePath}/${ParamsPage.routePath}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
