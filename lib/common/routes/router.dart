import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:testing/_placeholder.dart';
import 'package:testing/common/routes/layout.dart';
import 'package:testing/common/routes/names.dart';
import 'package:testing/pages/home/home_page.dart';
import 'package:testing/pages/profile/help_center/help_center_page.dart';
import 'package:testing/pages/profile/profile_settings/profile_settings_page.dart';

final _rootNagivatorKey = GlobalKey<NavigatorState>(debugLabel: "root");
final router = GoRouter(
  navigatorKey: _rootNagivatorKey,
  initialLocation: Routes.profilePage,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => LayoutScaffold(
        navigationShell: navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.homePage,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.ordersPage,
              builder: (context, state) => const PlaceHolderPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.searchPage,
              builder: (context, state) => const PlaceHolderPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.reelsPage,
              builder: (context, state) => const PlaceHolderPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.profilePage,
              builder: (context, state) => const ProfileSettingsPage(),
              routes: [
                GoRoute(
                  path: Routes.helpCenterPage,
                  builder: (context, state) => HelpCenterPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    )
  ],
);
