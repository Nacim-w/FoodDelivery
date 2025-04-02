import 'package:flutter/material.dart';
import 'package:testing/pages/profile/profile_settings/widgets/profile_settings_widgets.dart';

Widget buildPage(int index, BuildContext context) {
  List<Widget> widget = [
    profileSettingsform(context),
    Center(child: Text("test2")),
    Center(child: Text("test3")),
    Center(child: Text("test4")),
    profileSettingsform(context),
  ];
  return widget[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
    label: "home",
    icon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset("assets/icons/home.png"),
    ),
    activeIcon: SizedBox(
      width: 15,
      height: 15,
      child: Image.asset(
        "assets/icons/home.png",
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
