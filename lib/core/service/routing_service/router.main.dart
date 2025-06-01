part of 'router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");

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
                  path: OrderTrackingMapView.routePath,
                  builder: (context, state) => const OrderTrackingMapView(),
                ),
                GoRoute(
                  path: BurgerCustomizationScreen.routePath,
                  builder: (context, state) => const BeginCustomization(),
                ),
                GoRoute(
                  path: FullCartView.routePath,
                  builder: (context, state) {
                    return BlocProvider(
                      create: (_) => sl<OrderCubit>(),
                      child: FullCartView(),
                    );
                  },
                ),
                GoRoute(
                  path: EmptyCartView.routePath,
                  builder: (context, state) {
                    return const EmptyCartView();
                  },
                ),
                GoRoute(
                  path: MapPage.routePath,
                  builder: (context, state) => const MapPage(),
                ),
                GoRoute(
                  path: PaymentPage.routePath,
                  builder: (context, state) => const PaymentPage(),
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
                  path: 'restaurant/:restaurantId',
                  builder: (context, state) {
                    final restaurantId = state.pathParameters['restaurantId']!;
                    return BlocProvider(
                      create: (_) => sl<RestaurantCubit>(),
                      child: RestaurantView(restaurantId: restaurantId),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'product/:productId',
                      builder: (context, state) {
                        final productId = state.pathParameters['productId']!;
                        return BlocProvider(
                          create: (_) => sl<ProductCubit>(),
                          child: ProductView(productId: productId),
                        );
                      },
                    ),
                  ],
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
                          path: 'restaurant/:productId',
                          builder: (context, state) {
                            final productId =
                                state.pathParameters['restaurantId']!;
                            return BlocProvider(
                              create: (_) => sl<ProductCubit>(),
                              child: ProductView(productId: productId),
                            );
                          },
                        ),
                      ],
                    ),
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
                  builder: (context, state) {
                    return BlocProvider(
                      create: (_) => sl<CategoryCubit>(),
                      child: CategoryView(),
                    );
                  },
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
              path: OrderHistoryView.routePath,
              builder: (context, state) {
                return BlocProvider(
                  create: (_) => sl<HistoryCubit>(),
                  child: OrderHistoryView(),
                );
              },
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
                  builder: (context, state) {
                    return BlocProvider(
                      create: (_) => sl<FavoriteCubit>(),
                      child: FavoriteView(),
                    );
                  },
                ),
                GoRoute(
                  path: ParamsView.routePath,
                  builder: (context, state) => const ParamsView(),
                  routes: [
                    GoRoute(
                      path: ChangePasswordView.routePath,
                      builder: (context, state) {
                        return BlocProvider(
                          create: (_) => sl<ProfileCubit>(),
                          child: ChangePasswordView(),
                        );
                      },
                    ),
                    GoRoute(
                      path: TermsServiceView.routePath,
                      builder: (context, state) => const TermsServiceView(),
                    ),
                    GoRoute(
                      path: PersonalDataPage.routePath,
                      builder: (context, state) {
                        return BlocProvider(
                          create: (_) => sl<ProfileCubit>(),
                          child: PersonalDataPage(),
                        );
                      },
                    ),
                  ],
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
        routes: [
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
            path: ForgotPasswordView.routePath,
            builder: (context, state) {
              return BlocProvider(
                create: (_) => sl<AuthCubit>(),
                child: ForgotPasswordView(),
              );
            },
            routes: [
              GoRoute(
                  path: OtpView.routePath,
                  builder: (context, state) {
                    return BlocProvider(
                      create: (_) => sl<AuthCubit>(),
                      child: OtpView(),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: ChangePasswordPage.routePath,
                      builder: (context, state) {
                        return BlocProvider(
                          create: (_) => sl<AuthCubit>(),
                          child: ChangePasswordPage(),
                        );
                      },
                    ),
                  ]),
            ],
          ),
        ]),
  ],
);
