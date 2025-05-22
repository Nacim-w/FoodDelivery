part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _authInit();
  await _homeInit();
  await _restaurantInit();
  await _searchInit();
  await _productInit();
  await _cacheInit();
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
    ..registerLazySingleton(() => HomeService());
}

Future<void> _restaurantInit() async {
  sl
    ..registerFactory(() => RestaurantCubit(restaurantsService: sl()))
    ..registerLazySingleton(() => RestaurantService());
}

Future<void> _searchInit() async {
  sl
    ..registerFactory(() => SearchCubit(searchService: sl()))
    ..registerLazySingleton(() => SearchService(sl()));
}

Future<void> _productInit() async {
  sl
    ..registerFactory(() => ProductCubit(productService: sl()))
    ..registerLazySingleton(() => ProductService());
}
