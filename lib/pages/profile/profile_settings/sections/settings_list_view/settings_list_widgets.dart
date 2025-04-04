import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/pages/profile/help_center/help_center_page.dart';
import 'package:testing/pages/profile/params/params_page.dart';
import 'package:testing/pages/profile/personal_data/personal_data_page.dart';
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
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PersonalDataPage()),
              ),
            ),
            BuildListTile(
              icon: Media.parametre,
              title: "Paramètres",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Params()),
              ),
            ),
            BuildListTile(
              icon: Media.language,
              title: "Sélectionner la langue",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Params(),
                ),
              ),
            ),
            Gap(10),
            buildSectionTitle("Support"),
            BuildListTile(
              icon: Media.help,
              title: "Centre d'aide",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpCenterPage()),
              ),
            ),
            BuildListTile(
              icon: Media.deleteAccount,
              title: "Supprimer mon compte",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PersonalDataPage()),
              ),
            ),
            BuildListTile(
              icon: Media.addAccount,
              title: "Ajouter un autre compte",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PersonalDataPage()),
              ),
            ),
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
    child: Text(title, style: TextStyles.textBoldSmallest.black),
  );
}
