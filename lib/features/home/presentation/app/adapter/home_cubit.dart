import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/home/presentation/app/adapter/home_state.dart';
import 'package:legy/features/home/service/home_service.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService homeService;

  HomeCubit({required this.homeService}) : super(HomeState());

  Future<void> loadRestaurants() async {
    print('loadRestaurants called');

    emit(state.copyWith(
      isLoadingRestaurants: true,
      clearRestaurantsError: true,
      restaurants: null,
    ));
    print(
        'After emit loading true & reset error: ${state.restaurantsError}'); // May still be old state because emit is async

    try {
      final restaurants = await homeService.getNearbyRestaurants(
        longitude: 73.4447,
        latitude: 44.6928,
        maxDistanceKm: 10000,
        limit: 10,
      );

      emit(state.copyWith(
        restaurants: restaurants,
        isLoadingRestaurants: false,
        clearRestaurantsError: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        restaurantsError: 'Failed to load restaurants: $e',
        isLoadingRestaurants: false,
      ));
    }
  }

  Future<void> loadProfile() async {
    emit(state.copyWith(isLoadingProfile: true));
    try {
      final profile = await homeService.getProfile();

      emit(state.copyWith(profile: profile, isLoadingProfile: false));
    } catch (e) {
      emit(state.copyWith(
        profileError: 'Failed to load profile: $e',
        isLoadingProfile: false,
      ));
    }
  }

  Future<void> loadStories() async {
    emit(state.copyWith(isLoadingStories: true));
    try {
      final stories = await homeService.getStories();

      emit(state.copyWith(stories: stories, isLoadingStories: false));
    } catch (e) {
      emit(state.copyWith(
        storiesError: 'Failed to load stories: $e',
        isLoadingStories: false,
      ));
    }
  }
}
