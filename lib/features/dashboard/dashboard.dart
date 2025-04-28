import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dashboard/bottom_nav_items.dart';
import 'package:legy/features/dashboard/drawer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('DashboardPage'));

  final StatefulNavigationShell navigationShell;

  bool get isHomeTab => navigationShell.currentIndex == 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      body: Column(
        children: [
          Gap(30),
          Expanded(
            child: navigationShell,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: destinations,
        onTap: (index) => navigationShell.goBranch(index),
        currentIndex: navigationShell.currentIndex,
        selectedItemColor: Colours.lightThemeOrange5,
        elevation: 5,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyles.textBoldSmallest.orange5,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
