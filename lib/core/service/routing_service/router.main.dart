part of 'router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  errorBuilder: (context, state) => const ErrorPage(),
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        final sessionToken = Cache.instance.sessionToken;
        if (sessionToken != null) {
          return HomePage.routePath;
        }
        return SignInPage.routePath;
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          DashboardPage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: HomePage.routePath,
              builder: (context, state) {
                return BlocProvider(
                  create: (_) => sl<HomeCubit>(),
                  child: HomePage(),
                );
              },
              routes: [
                GoRoute(
                  path: BurgerCustomizationScreen.routePath,
                  builder: (context, state) => const BeginCustomization(),
                ),
                GoRoute(
                  path: PaymentPage.routePath,
                  builder: (context, state) => const PaymentPage(),
                ),
                GoRoute(
                  path: FullCart.routePath,
                  builder: (context, state) => const FullCart(),
                ),
                GoRoute(
                  path: MapPage.routePath,
                  builder: (context, state) => const MapPage(),
                ),
                GoRoute(
                  path: EmptyCart.routePath,
                  builder: (context, state) => const FullCart(),
                ),
                GoRoute(
                  path: CouponView.routePath,
                  builder: (context, state) => const CouponView(),
                ),
                GoRoute(
                  path: NotificationView.routePath,
                  builder: (context, state) => const NotificationView(),
                ),
                GoRoute(
                  path: AllRestaurantsView.routePath,
                  builder: (context, state) {
                    return BlocProvider(
                      create: (_) => sl<RestaurantCubit>(),
                      child: AllRestaurantsView(),
                    );
                  },
                  routes: [
                    GoRoute(
                        path: 'restaurant/:restaurantId',
                        builder: (context, state) {
                          final restaurantId =
                              state.pathParameters['restaurantId']!;
                          return BlocProvider(
                            create: (_) => sl<RestaurantCubit>(),
                            child: RestaurantView(restaurantId: restaurantId),
                          );
                        },
                        routes: [
                          GoRoute(
                            path: ProductView.routePath,
                            builder: (context, state) => const ProductView(),
                          ),
                        ]),
                  ],
                ),
                GoRoute(
                  path: CategoryDessertDetails.routePath,
                  builder: (context, state) => const CategoryDessertDetails(),
                  routes: [
                    GoRoute(
                      path: DessertDetails.routePath,
                      builder: (context, state) => const DessertDetails(),
                    ),
                  ],
                ),
                GoRoute(
                  path: CategoryDetails.routePath,
                  builder: (context, state) => const CategoryView(),
                  routes: [
                    GoRoute(
                      path: SaladDetails.routePath,
                      builder: (context, state) => const SaladDetails(),
                    ),
                    GoRoute(
                      path: BurgerDetails.routePath,
                      builder: (context, state) => const BurgerDetails(),
                    ),
                    GoRoute(
                      path: PizzaDetails.routePath,
                      builder: (context, state) => const PizzaDetails(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: OrderHistoryPage.routePath,
              builder: (context, state) => const EmptyHistoryView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: SearchView.routePath,
              builder: (context, state) {
                return BlocProvider(
                  create: (_) => sl<SearchCubit>(),
                  child: SearchView(),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: ReelsView.routePath,
              builder: (context, state) => const ReelsView(),
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
                  path: FavoriteView.routePath,
                  builder: (context, state) => const FavoriteView(),
                ),
                GoRoute(
                    path: ParamsView.routePath,
                    builder: (context, state) => const ParamsView(),
                    routes: [
                      GoRoute(
                        path: TermsServiceView.routePath,
                        builder: (context, state) => const TermsServiceView(),
                      ),
                    ]),
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
    GoRoute(
      path: SignInPage.routePath,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => sl<AuthCubit>(),
          child: SignInPage(),
        );
      },
    ),
    GoRoute(
      path: SignUpPage.routePath,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => sl<AuthCubit>(),
          child: SignUpPage(),
        );
      },
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
