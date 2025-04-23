part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _authInit();
  await _homeInit();
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
