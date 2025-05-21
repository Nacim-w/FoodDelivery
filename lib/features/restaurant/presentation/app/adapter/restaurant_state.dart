import 'package:equatable/equatable.dart';
import 'package:legy/features/restaurant/model/restaurant_category_model.dart';
import 'package:legy/features/restaurant/model/restaurant_model.dart';
import 'package:legy/features/restaurant/model/restaurant_product_model.dart';

class RestaurantState extends Equatable {
  final List<RestaurantModel>? restaurants;
  final RestaurantModel? selectedRestaurant;
  final List<RestaurantCategoryModel>? categories;
  final List<RestaurantProductModel>? products;

  final bool isLoadingRestaurants;
  final bool isLoadingRestaurantById;
  final bool isLoadingCategories;
  final bool isLoadingProducts;

  final String? restaurantsError;
  final String? restaurantError;
  final String? categoriesError;
  final String? productsError;
  final String? selectedCategoryId;

  const RestaurantState({
    this.restaurants,
    this.selectedRestaurant,
    this.categories,
    this.products,
    this.isLoadingRestaurants = false,
    this.isLoadingRestaurantById = false,
    this.isLoadingCategories = false,
    this.isLoadingProducts = false,
    this.restaurantsError,
    this.restaurantError,
    this.categoriesError,
    this.productsError,
    this.selectedCategoryId,
  });

  RestaurantState copyWith({
    List<RestaurantModel>? restaurants,
    RestaurantModel? selectedRestaurant,
    List<RestaurantCategoryModel>? categories,
    List<RestaurantProductModel>? products,
    bool? isLoadingRestaurants,
    bool? isLoadingRestaurantById,
    bool? isLoadingCategories,
    bool? isLoadingProducts,
    String? restaurantsError,
    String? restaurantError,
    String? categoriesError,
    String? productsError,
    String? selectedCategoryId,
  }) {
    return RestaurantState(
      restaurants: restaurants ?? this.restaurants,
      selectedRestaurant: selectedRestaurant ?? this.selectedRestaurant,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      isLoadingRestaurants: isLoadingRestaurants ?? this.isLoadingRestaurants,
      isLoadingRestaurantById:
          isLoadingRestaurantById ?? this.isLoadingRestaurantById,
      isLoadingProducts: isLoadingProducts ?? this.isLoadingProducts,
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      restaurantsError: restaurantsError ?? this.restaurantsError,
      restaurantError: restaurantError ?? this.restaurantError,
      categoriesError: categoriesError ?? this.categoriesError,
      productsError: productsError ?? this.productsError,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }

  @override
  List<Object?> get props => [
        restaurants,
        selectedRestaurant,
        categories,
        products,
        isLoadingRestaurants,
        isLoadingRestaurantById,
        isLoadingCategories,
        isLoadingProducts,
        restaurantsError,
        restaurantError,
        categoriesError,
        productsError,
        selectedCategoryId,
      ];
}
