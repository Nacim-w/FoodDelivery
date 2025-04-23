import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/home/presentation/app/adapter/home_state.dart';
import 'package:legy/features/home/service/home_service.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService homeService;

  HomeCubit({required this.homeService}) : super(HomeInitial());

  Future<void> loadCategories() async {
    emit(HomeLoading());
    try {
      final responseCategories = await homeService.getTopCategories();

      final categories = responseCategories;

      emit(
        CategoriesLoaded(categories: categories),
      );
    } catch (e, stackTrace) {
      debugPrint('Error loading categories: $e');
      debugPrint('StackTrace: $stackTrace');
      emit(HomeError(message: 'Failed to load categories: $e'));
    }
  }

  Future<void> loadRestaurants() async {
    emit(HomeLoading());
    try {
      final responseRestaurants = await homeService.getNearbyRestaurants(
          longitude: 73.4447,
          latitude: 44.6928,
          maxDistanceKm: 10000,
          limit: 10000);

      final restaurants = responseRestaurants;

      emit(
        RestaurantsLoaded(restaurants: restaurants),
      );
    } catch (e, stackTrace) {
      debugPrint('Error loading restaurants: $e');
      debugPrint('StackTrace: $stackTrace');
      emit(HomeError(message: 'Failed to load restaurants: $e'));
    }
  }
}
