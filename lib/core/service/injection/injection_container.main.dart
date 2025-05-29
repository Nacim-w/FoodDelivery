part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _cacheInit();
  await _authInit();
  await _homeInit();
  await _restaurantInit();
  await _searchInit();
  await _productInit();
  await _profileInit();
  await _favoriteInit();
  await _historyInit();
  await _orderInit();
}

Future<void> _cacheInit() async {
  final prefs = await SharedPreferences.getInstance();
  sl
    ..registerLazySingleton(() => CacheHelper(sl()))
    ..registerLazySingleton(() => prefs);
  sl<CacheHelper>().getSessionToken();
}

Future<void> _authInit() async {
  sl
    ..registerFactory(() => AuthCubit(authService: sl()))
    ..registerLazySingleton(() => AuthService());
}

Future<void> _homeInit() async {
  sl
    ..registerFactory(() => HomeCubit(homeService: sl()))
    ..registerLazySingleton(() => HomeService(sl()));
}

Future<void> _restaurantInit() async {
  sl
    ..registerFactory(() => RestaurantCubit(restaurantsService: sl()))
    ..registerLazySingleton(() => RestaurantService(sl()));
}

Future<void> _searchInit() async {
  sl
    ..registerFactory(() => SearchCubit(searchService: sl()))
    ..registerLazySingleton(() => SearchService(sl()));
}

Future<void> _productInit() async {
  sl
    ..registerFactory(() => ProductCubit(productService: sl()))
    ..registerLazySingleton(() => ProductService(sl()));
}

Future<void> _profileInit() async {
  sl
    ..registerFactory(() => ProfileCubit(profileService: sl()))
    ..registerLazySingleton(() => ProfileService(sl()));
}

Future<void> _favoriteInit() async {
  sl
    ..registerFactory(() => FavoriteCubit(favoriteService: sl()))
    ..registerLazySingleton(() => FavoriteService(sl()));
}

Future<void> _orderInit() async {
  sl
    ..registerFactory(() => OrderCubit(orderService: sl()))
    ..registerLazySingleton(() => OrderService(sl()));
}

Future<void> _historyInit() async {
  sl
    ..registerFactory(() => HistoryCubit(historyService: sl()))
    ..registerLazySingleton(() => HistoryService(sl()));
}
