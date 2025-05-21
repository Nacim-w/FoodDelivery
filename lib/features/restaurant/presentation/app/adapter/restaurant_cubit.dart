import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_state.dart';
import 'package:legy/features/restaurant/service/restaurant_service.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final RestaurantService restaurantsService;

  RestaurantCubit({required this.restaurantsService})
      : super(const RestaurantState());

  Future<void> loadRestaurants() async {
    emit(state.copyWith(
      isLoadingRestaurants: true,
      restaurantsError: null,
    ));

    try {
      final restaurants = await restaurantsService.getRestaurants();
      emit(state.copyWith(
        isLoadingRestaurants: false,
        restaurants: restaurants,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingRestaurants: false,
        restaurantsError: e.toString(),
      ));
    }
  }

  Future<void> loadRestaurantById(String restaurantId) async {
    emit(state.copyWith(
      isLoadingRestaurantById: true,
      restaurantError: null,
    ));

    try {
      final restaurant =
          await restaurantsService.getRestaurantById(restaurantId);
      emit(state.copyWith(
        isLoadingRestaurantById: false,
        selectedRestaurant: restaurant,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingRestaurantById: false,
        restaurantError: e.toString(),
      ));
    }
  }

  Future<void> loadCategoriesByRestaurantId(String restaurantId) async {
    emit(state.copyWith(
      isLoadingCategories: true,
      categoriesError: null,
    ));

    try {
      final categories =
          await restaurantsService.getRestaurantCategoriesById(restaurantId);
      emit(state.copyWith(
        isLoadingCategories: false,
        categories: categories,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingCategories: false,
        categoriesError: e.toString(),
      ));
    }
  }

  Future<void> loadProductsByRestaurantId(
      String restaurantId, String categoryId) async {
    emit(state.copyWith(
      isLoadingProducts: true,
      products: null,
    ));

    try {
      final products = await restaurantsService.getRestaurantProducts(
          restaurantId, categoryId);
      emit(state.copyWith(
        isLoadingProducts: false,
        products: products,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingProducts: false,
        productsError: e.toString(),
      ));
    }
  }
}
