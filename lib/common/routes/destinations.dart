import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/colours.dart';

class Destinations {
  const Destinations(
      {required this.label,
      required this.inactiveIcon,
      required this.activeicon});

  final String label;
  final String inactiveIcon;
  final String activeicon;
}

var destinations = [
  BottomNavigationBarItem(
    label: "Home",
    icon: inactiveIcon(Media.home),
    activeIcon: activeIcon(
      Media.homeActive,
    ),
  ),
  BottomNavigationBarItem(
    label: "Orders",
    icon: inactiveIcon(Media.orders),
    activeIcon: activeIcon(
      Media.ordersActive,
    ),
  ),
  BottomNavigationBarItem(
    label: "Search",
    icon: inactiveIcon(Media.search),
    activeIcon: activeIcon(
      Media.searchActive,
    ),
  ),
  BottomNavigationBarItem(
    label: "Reels",
    icon: inactiveIcon(Media.reels),
    activeIcon: activeIcon(
      Media.reelsActive,
    ),
  ),
  BottomNavigationBarItem(
    label: "Profile",
    icon: inactiveIcon(Media.guest),
    activeIcon: activeIcon(
      Media.guestActive,
    ),
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

Widget activeIcon(String icon) {
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
