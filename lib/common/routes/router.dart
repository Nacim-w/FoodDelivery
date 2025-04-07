import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:testing/_placeholder.dart';
import 'package:testing/common/routes/bottom_nav.dart';
import 'package:testing/common/routes/names.dart';
import 'package:testing/pages/auth/change_password/change_password_page.dart';
import 'package:testing/pages/auth/forgot_password/forgot_password_page.dart';
import 'package:testing/pages/auth/opt/otp_page.dart';
import 'package:testing/pages/auth/sign_up/sign_up_page.dart';
import 'package:testing/pages/auth/sign_in/sign_in_page.dart';
import 'package:testing/pages/home/home_page.dart';
import 'package:testing/pages/profile/help_center/help_center_page.dart';
import 'package:testing/pages/profile/params/params_page.dart';
import 'package:testing/pages/profile/personal_data/personal_data_page.dart';
import 'package:testing/pages/profile/profile_settings/profile_settings_page.dart';

final _rootNagivatorKey = GlobalKey<NavigatorState>(debugLabel: "root");
final router = GoRouter(
  navigatorKey: _rootNagivatorKey,
  initialLocation: Routes.signInPage,
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
                  path: Routes.nestedHelpCenterPage,
                  builder: (context, state) => HelpCenterPage(),
                ),
                GoRoute(
                  path: Routes.nestedParamsPage,
                  builder: (context, state) => ParamsPage(),
                ),
                GoRoute(
                  path: Routes.nestedPersonalDataPage,
                  builder: (context, state) => PersonalDataPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: Routes.signInPage,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: Routes.signUpPage,
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: Routes.forgotPasswordPage,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: Routes.changePasswordPage,
      builder: (context, state) => const ChangePasswordPage(),
    ),
    GoRoute(
      path: Routes.otpPage,
      builder: (context, state) => const OtpPage(),
    ),
  ],
);
