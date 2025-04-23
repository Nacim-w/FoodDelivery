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
      /*final responseRestaurants = await homeService.getNearbyRestaurants(
          longitude: 11, latitude: 28, maxDistanceKm: 100, limit: 100);
*/
      final categories = responseCategories;
      //final restaurants = responseRestaurants;

      emit(
        HomeLoaded(categories: categories),
      );
    } catch (e, stackTrace) {
      debugPrint('Error loading categories: $e');
      debugPrint('StackTrace: $stackTrace');
      emit(HomeError(message: 'Failed to load categories: $e'));
    }
  }
}
