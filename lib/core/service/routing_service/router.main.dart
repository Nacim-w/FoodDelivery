part of 'router.dart';

// import 'package:flutter/material.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");

CustomTransitionPage<T> fadeTransition<T>({required Widget child}) =>
    CustomTransitionPage<T>(
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    );

CustomTransitionPage<T> slideUpTransition<T>({required Widget child}) =>
    CustomTransitionPage<T>(
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
            .animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: child,
      ),
    );

CustomTransitionPage<T> slideHorizontalTransition<T>({required Widget child}) =>
    CustomTransitionPage<T>(
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: child,
      ),
    );

CustomTransitionPage<T> sharedAxisTransition<T>({
  required Widget child,
  SharedAxisTransitionType type = SharedAxisTransitionType.horizontal,
}) =>
    CustomTransitionPage<T>(
      transitionDuration: const Duration(milliseconds: 800),
      reverseTransitionDuration: const Duration(milliseconds: 600),
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: type,
        child: child,
      ),
    );

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
              pageBuilder: (context, state) => sharedAxisTransition(
                child: BlocProvider(
                  create: (_) => sl<HomeCubit>(),
                  child: HomePage(),
                ),
              ),
              routes: [
                GoRoute(
                  path: TrackingView.routePath,
                  pageBuilder: (context, state) => slideUpTransition(
                    child: BlocProvider(
                      create: (_) => sl<TrackingCubit>(),
                      child: TrackingView(orderId: ''),
                    ),
                  ),
                ),
                GoRoute(
                  path: PreferencesView.routePath,
                  pageBuilder: (context, state) =>
                      fadeTransition(child: const PreferencesView()),
                ),
                GoRoute(
                  path: OrderTrackingMapView.routePath,
                  pageBuilder: (context, state) => slideUpTransition(
                    child: const OrderTrackingMapView(),
                  ),
                ),
                GoRoute(
                  path: BeginCustomization.routePath,
                  pageBuilder: (context, state) => slideUpTransition(
                    child: const BeginCustomization(),
                  ),
                  routes: [
                    GoRoute(
                      path: BurgerFinalScreen.routePath,
                      pageBuilder: (context, state) {
                        final ingredients = state.extra as List<String>;
                        return slideHorizontalTransition(
                          child: BurgerFinalScreen(ingredients: ingredients),
                        );
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: FullCartView.routePath,
                  pageBuilder: (context, state) => fadeTransition(
                    child: BlocProvider(
                      create: (_) => sl<OrderCubit>(),
                      child: FullCartView(),
                    ),
                  ),
                ),
                GoRoute(
                  path: EmptyCartView.routePath,
                  pageBuilder: (context, state) =>
                      fadeTransition(child: const EmptyCartView()),
                ),
                GoRoute(
                  path: MapView.routePath,
                  pageBuilder: (context, state) => slideUpTransition(
                    child: const MapView(),
                  ),
                ),
                GoRoute(
                  path: PaymentPage.routePath,
                  pageBuilder: (context, state) => slideUpTransition(
                    child: const PaymentPage(),
                  ),
                ),
                GoRoute(
                  path: CouponView.routePath,
                  pageBuilder: (context, state) =>
                      fadeTransition(child: const CouponView()),
                ),
                GoRoute(
                  path: 'restaurant/:restaurantId',
                  pageBuilder: (context, state) {
                    final restaurantId = state.pathParameters['restaurantId']!;
                    return slideHorizontalTransition(
                      child: BlocProvider(
                        create: (_) => sl<RestaurantCubit>(),
                        child: RestaurantView(restaurantId: restaurantId),
                      ),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'product/:productId',
                      pageBuilder: (context, state) {
                        final productId = state.pathParameters['productId']!;
                        return slideHorizontalTransition(
                          child: BlocProvider(
                            create: (_) => sl<ProductCubit>(),
                            child: ProductView(productId: productId),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: AllRestaurantsView.routePath,
                  pageBuilder: (context, state) => fadeTransition(
                    child: BlocProvider(
                      create: (_) => sl<RestaurantCubit>(),
                      child: AllRestaurantsView(),
                    ),
                  ),
                  routes: [
                    GoRoute(
                      path: 'restaurant/:restaurantId',
                      pageBuilder: (context, state) {
                        final restaurantId =
                            state.pathParameters['restaurantId']!;
                        return slideHorizontalTransition(
                          child: BlocProvider(
                            create: (_) => sl<RestaurantCubit>(),
                            child: RestaurantView(restaurantId: restaurantId),
                          ),
                        );
                      },
                      routes: [
                        GoRoute(
                          path: 'restaurant/:productId',
                          pageBuilder: (context, state) {
                            final productId =
                                state.pathParameters['restaurantId']!;
                            return slideHorizontalTransition(
                              child: BlocProvider(
                                create: (_) => sl<ProductCubit>(),
                                child: ProductView(productId: productId),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                GoRoute(
                  path: CategoryDetails.routePath,
                  pageBuilder: (context, state) => sharedAxisTransition(
                    child: BlocProvider(
                      create: (_) => sl<CategoryCubit>(),
                      child: CategoryView(),
                    ),
                  ),
                  routes: [
                    GoRoute(
                      path: SaladDetails.routePath,
                      pageBuilder: (context, state) =>
                          slideHorizontalTransition(
                        child: const SaladDetails(),
                      ),
                    ),
                    GoRoute(
                      path: BurgerDetails.routePath,
                      pageBuilder: (context, state) =>
                          slideHorizontalTransition(
                        child: const BurgerDetails(),
                      ),
                    ),
                    GoRoute(
                      path: PizzaDetails.routePath,
                      pageBuilder: (context, state) =>
                          slideHorizontalTransition(
                        child: const PizzaDetails(),
                      ),
                    ),
                    GoRoute(
                      path: DessertDetails.routePath,
                      pageBuilder: (context, state) =>
                          slideHorizontalTransition(
                        child: const DessertDetails(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // Order history branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: OrderHistoryView.routePath,
              builder: (context, state) => BlocProvider(
                create: (_) => sl<HistoryCubit>(),
                child: OrderHistoryView(),
              ),
              routes: [
                GoRoute(
                  path: OrderDetailsView.routePath + '/:orderId',
                  builder: (context, state) {
                    final orderId = state.pathParameters['orderId']!;
                    return BlocProvider(
                      create: (_) => sl<OrderDetailsCubit>(),
                      child: OrderDetailsView(orderId: orderId),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        // Search branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: SearchView.routePath,
              builder: (context, state) => BlocProvider(
                create: (_) => sl<SearchCubit>(),
                child: SearchView(),
              ),
            ),
          ],
        ),
        // Reels branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: ReelsView.routePath,
              builder: (context, state) => BlocProvider(
                create: (_) => sl<ReelsCubit>(),
                child: ReelsView(),
              ),
            ),
          ],
        ),
        // Profile/settings branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: ProfileSettingsPage.routePath,
              builder: (context, state) => const ProfileSettingsPage(),
              routes: [
                GoRoute(
                  path: NotificationView.routePath,
                  builder: (context, state) => const NotificationView(),
                ),
                GoRoute(
                  path: HelpCenterPage.routePath,
                  builder: (context, state) => const HelpCenterPage(),
                ),
                GoRoute(
                  path: FavoriteView.routePath,
                  builder: (context, state) => BlocProvider(
                    create: (_) => sl<FavoriteCubit>(),
                    child: FavoriteView(),
                  ),
                ),
                GoRoute(
                  path: ParamsView.routePath,
                  builder: (context, state) => const ParamsView(),
                  routes: [
                    GoRoute(
                      path: ChangePasswordView.routePath,
                      builder: (context, state) => BlocProvider(
                        create: (_) => sl<ProfileCubit>(),
                        child: ChangePasswordView(),
                      ),
                    ),
                    GoRoute(
                      path: TermsServiceView.routePath,
                      builder: (context, state) => const TermsServiceView(),
                    ),
                    GoRoute(
                      path: PersonalDataPage.routePath,
                      builder: (context, state) => BlocProvider(
                        create: (_) => sl<ProfileCubit>(),
                        child: PersonalDataPage(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    // Sign-in flow
    GoRoute(
      path: SignInPage.routePath,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: SignInPage(),
      ),
      routes: [
        GoRoute(
          path: CompleteProfileView.routePath,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: CompleteProfileView(),
          ),
        ),
        GoRoute(
          path: SignUpPage.routePath,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: SignUpPage(),
          ),
        ),
        GoRoute(
          path: ForgotPasswordView.routePath,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: ForgotPasswordView(),
          ),
          routes: [
            GoRoute(
              path: OtpView.routePath,
              builder: (context, state) => BlocProvider(
                create: (_) => sl<AuthCubit>(),
                child: OtpView(),
              ),
              routes: [
                GoRoute(
                  path: ChangePasswordPage.routePath,
                  builder: (context, state) => BlocProvider(
                    create: (_) => sl<AuthCubit>(),
                    child: ChangePasswordPage(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
