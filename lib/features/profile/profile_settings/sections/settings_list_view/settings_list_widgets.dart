import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/features/notification/presentation/view/notification_view.dart';
import 'package:legy/features/profile/favorite/presentation/views/favorite_view.dart';
import 'package:legy/features/profile/help_center/help_center_page.dart';
import 'package:legy/features/profile/params/presentation/views/params_view.dart';
import 'package:legy/features/profile/profile_settings/profile_settings_page.dart';
import 'package:legy/features/profile/profile_settings/sections/logout/build_backdrop_filter_widget.dart';
import 'package:legy/features/profile/profile_settings/sections/settings_list_view/profile_build_list_tile_widget.dart';
import 'package:legy/features/profile/profile_settings/sections/settings_list_view/settings_categorie._widget.dart';

class BuiltListView extends StatelessWidget {
  const BuiltListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SettingsCategorieWidget(
                icon: Media.location,
                text: "Adresses",
              ),
              Gap(20),
              GestureDetector(
                onTap: () => context.go(
                    '${ProfileSettingsPage.routePath}/${NotificationView.routePath}'),
                child: SettingsCategorieWidget(
                  icon: Media.notification,
                  text: "Notification",
                ),
              ),
            ],
          ),
        ),
        Gap(20),
        BuildListTile(
          icon: Media.favorites,
          title: "Mes favoris",
          onTap: () => context
              .go('${ProfileSettingsPage.routePath}/${FavoriteView.routePath}'),
        ),
        BuildListTile(
          icon: Media.helpCenter,
          title: "Centre d’aide",
          onTap: () => context.go(
              '${ProfileSettingsPage.routePath}/${HelpCenterPage.routePath}'),
        ),
        BuildListTile(
          icon: Media.parametre,
          title: "Paramètre",
          onTap: () => context
              .go('${ProfileSettingsPage.routePath}/${ParamsView.routePath}'),
        ),
        BuildListTile(
            icon: Media.logOut,
            title: "Se déconnecter",
            onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return BuildBackdropFilter();
                  },
                )),
        Gap(20),
      ],
    );
  }
}
