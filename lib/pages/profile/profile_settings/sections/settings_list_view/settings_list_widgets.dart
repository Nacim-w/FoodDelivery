import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/pages/profile/help_center/help_center_page.dart';
import 'package:testing/pages/profile/params/params_page.dart';
import 'package:testing/pages/profile/personal_data/personal_data_page.dart';
import 'package:testing/pages/profile/profile_settings/sections/logout/logout_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget builtListView(BuildContext context) {
  return Expanded(
    child: ListView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      children: [
        buildSectionTitle("Profil"),
        buildListTile(
          Media.personal,
          "Données personnelles",
          context,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PersonalDataPage()),
          ),
        ),
        buildListTile(
          Media.parametre,
          "Paramètres",
          context,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Params()),
          ),
        ),
        buildListTile(Media.language, "Sélectionner la langue", context,
            () => showLanguageModal(context)),

        Gap(10),
        buildSectionTitle("Support"),
        buildListTile(
          Media.help,
          "Centre d'aide",
          context,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HelpCenterPage()),
          ),
        ),
        buildListTile(
          Media.deleteAccount,
          "Supprimer mon compte",
          context,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PersonalDataPage()),
          ),
        ),
        buildListTile(
          Media.addAccount,
          "Ajouter un autre compte",
          context,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PersonalDataPage()),
          ),
        ),
        // Logout Button
        Padding(
          padding: EdgeInsets.all(16),
          child: OutlinedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return buildBackdropFilterDialog(context);
                },
              );
            },
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12),
              side: BorderSide(color: Colours.lightThemeBorderColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            icon: Icon(Icons.logout, color: Colours.lightThemeOrangeTextColor),
            label:
                Text("Se déconnecter", style: TextStyles.textSemiBold.orange),
          ),
        ),
      ],
    ),
  );
}

Widget buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 16, bottom: 8),
    child: Text(title, style: TextStyles.textBoldSmallest.black),
  );
}

Widget buildListTile(
    String icon, String title, BuildContext context, VoidCallback onTap) {
  return ListTile(
    leading: Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Color(0xFFFEE1CF),
      ),
      child: Center(
        child: SvgPicture.asset(
          width: 15,
          height: 17,
          icon,
        ),
      ),
    ),
    title: Text(title, style: TextStyles.textMedium.black),
    trailing: Icon(Icons.arrow_forward_ios,
        size: 16, color: Colours.lightThemePrimaryTextColor),
    onTap: onTap,
  );
}

void showLanguageModal(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    showDragHandle: true,
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.40,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colours.lightThemePrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sélectionner la langue",
                  style: TextStyles.textMedium,
                ),
                Gap(10),
                buildContinueButton(
                  context,
                  "Continue",
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
