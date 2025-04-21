import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/features/profile/profile_settings/sections/logout/build_backdrop_filter_widget.dart';
import 'package:legy/features/profile/profile_settings/sections/settings_list_view/profile_list_tile_widget.dart';
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
          onTap: () => context.push('/profile/params'),
        ),
        BuildListTile(
          icon: Media.helpCenter,
          title: "Centre d’aide",
          onTap: () => context.push('/profile/help-center'),
        ),
        BuildListTile(
          icon: Media.parametre,
          title: "Paramètre",
          onTap: () => context.push('/profile/params'),
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
