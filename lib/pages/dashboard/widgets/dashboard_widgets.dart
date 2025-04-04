import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/pages/profile/profile_settings/widgets/profile_settings_widgets.dart';

Widget buildPage(int index, BuildContext context) {
  List<Widget> widget = [
    ProfileSettingsForm(),
    Center(child: Text("test2")),
    Center(child: Text("test3")),
    Center(child: Text("test4")),
    ProfileSettingsForm()
  ];
  return widget[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
    label: "Home",
    icon: inactiveIcon(Media.home),
    activeIcon: activeIcon(Media.homeActive, "Home"),
  ),
  BottomNavigationBarItem(
    label: "Orders",
    icon: inactiveIcon(Media.orders),
    activeIcon: activeIcon(Media.ordersActive, "Orders"),
  ),
  BottomNavigationBarItem(
    label: "Search",
    icon: inactiveIcon(Media.search),
    activeIcon: activeIcon(Media.searchActive, "Search"),
  ),
  BottomNavigationBarItem(
    label: "Reels",
    icon: inactiveIcon(Media.reels),
    activeIcon: activeIcon(Media.reelsActive, "Reels"),
  ),
  BottomNavigationBarItem(
    label: "Profile",
    icon: inactiveIcon(Media.guest),
    activeIcon: activeIcon(Media.guestActive, "Profile"),
  ),
];

Widget inactiveIcon(icon) {
  return SizedBox(
    width: 20,
    height: 20,
    child: SvgPicture.asset(
      icon,
    ),
  );
}

Widget activeIcon(String icon, String label) {
  return Column(
    children: [
      Transform.translate(
        offset: Offset(0, -15),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colours.lightThemeOrangeTextColor,
          ),
          width: 40,
          height: 40,
          child: Center(
            child: SvgPicture.asset(
              icon,
            ),
          ),
        ),
      ),
    ],
  );
}
