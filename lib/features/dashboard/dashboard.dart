import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/category/presentation/widgets/category_details.dart';
import 'package:legy/features/dashboard/bottom_nav_items.dart';
import 'package:legy/features/dashboard/drawer.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_body/pizza_details.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('DashboardPage'));

  final StatefulNavigationShell navigationShell;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    final shouldHideBottomNav = [
      '${HomePage.routePath}/${CategoryDetails.routePath}/${PizzaDetails.routePath}',
    ];

    return Scaffold(
      drawer: const HomeDrawer(),
      body: widget.navigationShell,
      bottomNavigationBar: shouldHideBottomNav.contains(location)
          ? null
          : BottomNavigationBar(
              items: destinations,
              onTap: (index) => widget.navigationShell.goBranch(index),
              currentIndex: widget.navigationShell.currentIndex,
              selectedItemColor: Colours.lightThemeOrange5,
              elevation: 5,
              showUnselectedLabels: false,
              selectedLabelStyle: TextStyles.textBoldSmallest.orange5,
              type: BottomNavigationBarType.fixed,
            ),
    );
  }
}
