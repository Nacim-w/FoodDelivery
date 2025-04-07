import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/common/routes/names.dart';
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
            buildSectionTitle("Profil"),
            BuildListTile(
                icon: Media.personal,
                title: "Données personnelles",
                onTap: () => context.push(Routes.nestedPersonalDataPage)),
            BuildListTile(
                icon: Media.parametre,
                title: "Paramètres",
                onTap: () => context.push(Routes.nestedParamsPage)),
            BuildListTile(
                icon: Media.language,
                title: "Sélectionner la langue",
                onTap: () => context.push(Routes.placeHolderPage)),
            Gap(10),
            buildSectionTitle("Support"),
            BuildListTile(
              icon: Media.help,
              title: "Centre d'aide",
              onTap: () => context.push(Routes.nestedHelpCenterPage),
            ),
            BuildListTile(
                icon: Media.deleteAccount,
                title: "Supprimer mon compte",
                onTap: () => context.push(Routes.placeHolderPage)),
            BuildListTile(
                icon: Media.addAccount,
                title: "Ajouter un autre compte",
                onTap: () => context.push(Routes.placeHolderPage)),
            Outbutton(),
            Gap(100),
          ],
        ),
      ),
    );
  }
}

Widget buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 16, bottom: 8),
    child: Text(title, style: TextStyles.textBoldSmall.black),
  );
}
