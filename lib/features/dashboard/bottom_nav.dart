import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dashboard/bottom_nav_items.dart';

class LayoutScaffold extends StatelessWidget {
  const LayoutScaffold({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('LayoutScaffold'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          items: destinations,
          onTap: (index) {
            navigationShell.goBranch(index);
          },
          currentIndex: navigationShell.currentIndex,
          selectedItemColor: Colours.lightThemeOrange5,
          elevation: 5,
          showUnselectedLabels: false,
          selectedLabelStyle: TextStyles.textBoldSmallest.orange5,
          type: BottomNavigationBarType.fixed,
        ),
      );
}
