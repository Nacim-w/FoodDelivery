part of 'router.dart';

final _rootNagivatorKey = GlobalKey<NavigatorState>(debugLabel: "root");

final router = GoRouter(
  refreshListenable: Global.authNotifier,

  navigatorKey: _rootNagivatorKey,
  initialLocation: SignInPage.routePath,
  errorBuilder: (context, state) => const ErrorPage(),

  //  Redirect Logic
  redirect: (context, state) {
    final isLoggedIn = Global.authNotifier.isLoggedIn;
    final isLoggingIn = state.uri.toString() == SignInPage.routePath;

    if (!isLoggedIn && !isLoggingIn) {
      return SignInPage.routePath;
    }

    if (isLoggedIn && isLoggingIn) {
      return HomePage.routePath;
    }

    return null;
  },

  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          LayoutScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: HomePage.routePath,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: FullCart.routePath,
              builder: (context, state) => const FullCart(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: OrderHistoryPage.routePath,
              builder: (context, state) => const OrderHistoryPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: ErrorPage.routePath,
              builder: (context, state) => const ErrorPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: ProfileSettingsPage.routePath,
              builder: (context, state) => const ProfileSettingsPage(),
              routes: [
                GoRoute(
                  path: HelpCenterPage.routePath,
                  builder: (context, state) => const HelpCenterPage(),
                ),
                GoRoute(
                  path: ParamsPage.routePath,
                  builder: (context, state) => const ParamsPage(),
                ),
                GoRoute(
                  path: PersonalDataPage.routePath,
                  builder: (context, state) => const PersonalDataPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    // 🆓 Public Routes
    GoRoute(
      path: SignInPage.routePath,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: SignUpPage.routePath,
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: ForgotPasswordPage.routePath,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: ChangePasswordPage.routePath,
      builder: (context, state) => const ChangePasswordPage(),
    ),
    GoRoute(
      path: OtpPage.routePath,
      builder: (context, state) => const OtpPage(),
    ),
  ],
);
