import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dashboard/bottom_nav_items.dart';
import 'package:legy/features/dashboard/drawer.dart';
import 'package:legy/features/history/presentation/views/order_history_view.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/profile/profile_settings/profile_settings_page.dart';
import 'package:legy/features/reels/presentation/views/reels_view.dart';
import 'package:legy/features/search/presentation/view/search_view.dart';

class DashboardPage extends StatelessWidget {
  final Widget child;

  const DashboardPage({
    Key? key,
    required this.child,
  }) : super(key: key);

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    if (location.startsWith(HomePage.routePath)) return 0;
    if (location.startsWith(OrderHistoryView.routePath)) return 1;
    if (location.startsWith(SearchView.routePath)) return 2;
    if (location.startsWith(ReelsView.routePath)) return 3;
    if (location.startsWith(ProfileSettingsPage.routePath)) return 4;

    return 0; // default to home
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      drawer: const CustomHomeDrawer(),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colours.lightThemeOrange5,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyles.textBoldSmallest.orange5,
        type: BottomNavigationBarType.fixed,
        items: destinations,
        onTap: (index) {
          final paths = [
            HomePage.routePath,
            OrderHistoryView.routePath,
            SearchView.routePath,
            ReelsView.routePath,
            ProfileSettingsPage.routePath,
          ];
          context.go(paths[index]);
        },
      ),
    );
  }
}
