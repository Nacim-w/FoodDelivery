import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/routes/names.dart';
import 'package:testing/pages/profile/profile_settings/sections/logout/build_backdrop_filter_widget.dart';
import 'package:testing/pages/profile/profile_settings/sections/logout/logout_widgets.dart';
import 'package:testing/pages/profile/profile_settings/sections/settings_list_view/profile_list_tile_widget.dart';

class BuiltListView extends StatelessWidget {
  const BuiltListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          children: [
            BuildListTile(
              icon: Media.favorites,
              title: "Mes favoris",
              onTap: () => context.push(Routes.nestedPersonalDataPage),
            ),
            BuildListTile(
              icon: Media.helpCenter,
              title: "Centre d’aide",
              onTap: () => context.push(Routes.nestedHelpCenterPage),
            ),
            BuildListTile(
              icon: Media.parametre,
              title: "Paramètre",
              onTap: () => context.push(Routes.nestedParamsPage),
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
            Outbutton(),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
