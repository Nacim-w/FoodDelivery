import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/res/media.dart';
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SettingsCategorieWidget(
                icon: Media.orders,
                text: "Ordres",
              ),
              SettingsCategorieWidget(
                icon: Media.location,
                text: "Adresses",
              ),
              SettingsCategorieWidget(
                icon: Media.notification,
                text: "Notification",
              ),
            ],
          ),
        ),
        Gap(20),
        BuildListTile(
          icon: Media.favorites,
          title: "Mes favoris",
          onTap: () => context.push(
              '${ProfileSettingsPage.routePath}/${FavoriteView.routePath}'),
        ),
        BuildListTile(
          icon: Media.helpCenter,
          title: "Centre d’aide",
          onTap: () => context.push(
              '${ProfileSettingsPage.routePath}/${HelpCenterPage.routePath}'),
        ),
        BuildListTile(
          icon: Media.parametre,
          title: "Paramètre",
          onTap: () => context
              .push('${ProfileSettingsPage.routePath}/${ParamsView.routePath}'),
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
