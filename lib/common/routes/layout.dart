import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/common/routes/destinations.dart';

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
          selectedItemColor: Colours.lightThemeOrangeTextColor,
          elevation: 5,
          showUnselectedLabels: false,
          selectedLabelStyle: TextStyles.textBoldSmallest.orange,
          type: BottomNavigationBarType.fixed,
        ),
      );
}
