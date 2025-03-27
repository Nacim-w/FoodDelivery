import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/common/routes/names.dart';
import 'package:testing/common/widgets/common_widgets.dart';
import 'package:testing/pages/auth/auth_widgets/auth_widgets.dart';
import 'package:testing/pages/profile/params/params_page.dart';
import 'package:testing/pages/profile/personal_data/personal_data_page.dart';

Widget profileSettingsform(BuildContext context) {
  return Scaffold(
    backgroundColor: Colours.lightThemePrimaryColor,
    body: Column(
      children: [
        Gap(30),
        profileAvatar(),
        Gap(50),
        ordersContainer(context),
        Gap(20),
        builtListView(context),
      ],
    ),
  );
}

Widget profileAvatar() {
  return Column(
    children: [
      profilePictureStack(Media.profileAvatar),
      Gap(10),
      reusableText(
        "Asma".toUpperCase(),
      ),
      buildSlogan("asma@gmail.com"),
    ],
  );
}

Widget profilePictureStack(String picture) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      ClipOval(
        child: Image.asset(
          picture,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        bottom: 0,
        left: 55,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colours.lightThemeWhiteIconColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.camera_alt_rounded,
            color: Colours.lightThemeOrangeSecondaryTextColor,
            size: 14,
          ),
        ),
      ),
    ],
  );
}

Widget ordersContainer(BuildContext context) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    color: Colours.lightThemePrimaryColor,
    elevation: 1, // Adds shadow
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Mes commandes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Voir tout",
                style: TextStyle(
                  fontSize: 14,
                  color: Colours.lightThemeOrangeSecondaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Gap(15),

          // Order ID and Status Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: "ID de commande ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  children: [
                    TextSpan(
                      text: "888333777",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colours.lightThemeOrangeSecondaryTextColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "En cours de livraison",
                  style: TextStyle(
                      fontSize: 12, color: Colours.lightThemePrimaryColor),
                ),
              ),
            ],
          ),

          Gap(8),
          Divider(),
          Gap(8),
          Row(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  Media.order, // Replace with actual image
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              Gap(12),

              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Burger With Meat",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "\$ 12,230",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colours.lightThemeOrangeSecondaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Quantity
              Text(
                "14 articles",
                style: TextStyle(
                    fontSize: 14, color: Colours.lightThemePrimaryTextColor),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget builtListView(BuildContext context) {
  return Expanded(
    child: ListView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      children: [
        _buildSectionTitle("Profil"),
        _buildListTile(
          Media.personal,
          "Données personnelles",
          context,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PersonalDataPage()),
          ),
        ),
        _buildListTile(
          Media.parametre,
          "Paramètres",
          context,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Params()),
          ),
        ),
        _buildListTile(
          Media.language,
          "Sélectionner la langue",
          context,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PersonalDataPage()),
          ),
        ),
        Gap(10),
        _buildSectionTitle("Support"),
        _buildListTile(
          Media.help,
          "Centre d'aide",
          context,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PersonalDataPage()),
          ),
        ),
        _buildListTile(
          Media.deleteAccount,
          "Supprimer mon compte",
          context,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PersonalDataPage()),
          ),
        ),
        _buildListTile(
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
            icon: Icon(Icons.logout,
                color: Colours.lightThemeOrangeSecondaryTextColor),
            label: Text("Se déconnecter",
                style: TextStyles.textSemiBold.orangeSecondary),
          ),
        ),
      ],
    ),
  );
}

// Helper function to create section titles
Widget _buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 16, bottom: 8),
    child: Text(title, style: TextStyles.textSemiBold),
  );
}

// Helper function to create list items
Widget _buildListTile(
    String icon, String title, BuildContext context, VoidCallback onTap) {
  return ListTile(
    leading: Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colours.lightThemeWhiteIconColor,
      ),
      child: Image.asset(
        icon,
      ),
    ),
    title: Text(title, style: TextStyle(fontSize: 16)),
    trailing: Icon(Icons.arrow_forward_ios,
        size: 16, color: Colours.lightThemePrimaryTextColor),
    onTap: onTap,
  );
}

Widget buildPage(int index, BuildContext context) {
  List<Widget> widget = [
    profileSettingsform(context),
    Center(child: Text("test2")),
    Center(child: Text("test3")),
    Center(child: Text("test4")),
    Center(child: Text("test5")),
  ];
  return widget[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
    label: "home",
    icon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset("assets/icons/help.png"),
    ),
    activeIcon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset(
        "assets/icons/help.png",
      ),
    ),
  ),
  BottomNavigationBarItem(
    label: "Search",
    icon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset("assets/icons/notes.png"),
    ),
    activeIcon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset(
        "assets/icons/notes.png",
      ),
    ),
  ),
  BottomNavigationBarItem(
    label: "Course",
    icon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset("assets/icons/search.png"),
    ),
    activeIcon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset(
        "assets/icons/search.png",
      ),
    ),
  ),
  BottomNavigationBarItem(
    label: "Chat",
    icon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset("assets/icons/reels.png"),
    ),
    activeIcon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset(
        "assets/icons/reels.png",
      ),
    ),
  ),
  BottomNavigationBarItem(
    label: "Profile",
    icon: SizedBox(
      width: 25,
      height: 25,
      child: Image.asset("assets/images/avatar.png"),
    ),
    activeIcon: SizedBox(
      width: 25,
      height: 25,
      child: Image.asset(
        "assets/images/avatar.png",
      ),
    ),
  ),
];

Widget buildBackdropFilterDialog(BuildContext context) {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        width: 327,
        height: 184,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colours.lightThemePrimaryColor,
        ),
        child: content(context),
      ),
    ),
  );
}

Widget content(BuildContext context) {
  return Column(
    children: [
      Gap(8),
      Text(
        "Se déconnecter",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
      Gap(25),
      buildSlogan("Voulez-vous vous déconnecter ?"),
      Gap(25),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          logOutButton(
              context, "Annuler", "annuler", () => Navigator.pop(context)),
          logOutButton(
            context,
            "Déconnexion",
            "deconnexion",
            () => Navigator.of(context)
                .pushNamedAndRemoveUntil(AppRoutes.signIn, (route) => false),
          ),
        ],
      )
    ],
  );
}

Widget logOutButton(BuildContext context, String buttonName, String buttonType,
    Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: MediaQuery.of(context).size.width / 3,
      height: 50,
      decoration: BoxDecoration(
        color: buttonType == "deconnexion"
            ? Colours.lightThemeOrangeSecondaryTextColor
            : Colours.lightThemePrimaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
        border: Border.all(
          color: buttonType == "deconnexion"
              ? Colors.transparent
              : Colours.lightThemeBorderColor,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          buttonName,
          textAlign: TextAlign.center,
          style: buttonType == "deconnexion"
              ? TextStyles.textSemiBold.white
              : TextStyles.textSemiBold.black,
        ),
      ),
    ),
  );
}
