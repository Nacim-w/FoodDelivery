import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/home/presentation/app/adapter/home_state.dart';
import 'package:legy/features/home/service/home_service.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService homeService;

  HomeCubit({required this.homeService}) : super(HomeState());

  Future<void> loadCategories() async {
    emit(state.copyWith(isLoadingCategories: true, categoriesError: null));
    try {
      final categories = await homeService.getTopCategories();
      emit(state.copyWith(categories: categories, isLoadingCategories: false));
    } catch (e) {
      emit(state.copyWith(
        categoriesError: 'Failed to load categories: $e',
        isLoadingCategories: false,
      ));
    }
  }

  Future<void> loadRestaurants() async {
    emit(state.copyWith(isLoadingRestaurants: true, restaurantsError: null));
    try {
      final restaurants = await homeService.getNearbyRestaurants(
        longitude: 73.4447,
        latitude: 44.6928,
        maxDistanceKm: 10000,
        limit: 10,
      );
      emit(state.copyWith(
          restaurants: restaurants, isLoadingRestaurants: false));
    } catch (e) {
      emit(state.copyWith(
        restaurantsError: 'Failed to load restaurants: $e',
        isLoadingRestaurants: false,
      ));
    }
  }
}
