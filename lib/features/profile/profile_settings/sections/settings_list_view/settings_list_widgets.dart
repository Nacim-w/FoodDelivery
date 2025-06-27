import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/widgets/rounded_button.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/maps/map_page.dart';
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
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    showDragHandle: true,
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => const _AddressBottomSheet(),
                  );
                },
                child: SettingsCategorieWidget(
                  icon: Media.location,
                  text: "Adresses",
                ),
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

class _AddressBottomSheet extends StatelessWidget {
  const _AddressBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: context.width,
        height: context.height * 0.2,
        child: Column(
          children: [
            Text('Vos addresses', style: TextStyles.textSemiBoldLarge.black1),
            Gap(10),
            SvgPicture.asset(Media.location),
            Text(
              'Aucune adresse n\'a encore été ajoutée.',
              style: TextStyles.textRegularSmall,
            ),
            Gap(15),
            RoundedButton(
              text: '',
              widgetContentButton: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  Text('Ajoutez votre adresse'),
                ],
              ),
              backgroundColour: Colours.lightThemeOrange5,
              onPressed: () => context.go(
                '${HomePage.routePath}/${MapPage.routePath}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
