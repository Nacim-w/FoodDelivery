import 'package:equatable/equatable.dart';
import 'package:legy/features/restaurant/model/restaurant_category_model.dart';
import 'package:legy/features/restaurant/model/restaurant_model.dart';
import 'package:legy/features/restaurant/model/restaurant_product_model.dart';

class RestaurantState extends Equatable {
  final List<RestaurantModel>? restaurants;
  final RestaurantModel? selectedRestaurant;
  final List<RestaurantCategoryModel>? categories;
  final List<RestaurantProductModel>? products;
  final bool reviewSubmittedSuccessfully;

  final bool isLoadingRestaurants;
  final bool isLoadingRestaurantById;
  final bool isLoadingCategories;
  final bool isLoadingProducts;
  final bool isSelectedRestaurantFavorite;
  final bool isSubmittingReview;

  final String? restaurantsError;
  final String? restaurantError;
  final String? categoriesError;
  final String? productsError;
  final String? selectedCategoryId;
  final String? submitReviewError;

  const RestaurantState({
    this.restaurants,
    this.selectedRestaurant,
    this.categories,
    this.products,
    this.isLoadingRestaurants = false,
    this.isLoadingRestaurantById = false,
    this.isLoadingCategories = false,
    this.isLoadingProducts = false,
    this.isSelectedRestaurantFavorite = false,
    this.restaurantsError,
    this.restaurantError,
    this.categoriesError,
    this.productsError,
    this.selectedCategoryId,
    this.isSubmittingReview = false,
    this.submitReviewError,
    this.reviewSubmittedSuccessfully = false,
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
    bool? isSelectedRestaurantFavorite,
    String? restaurantsError,
    String? restaurantError,
    String? categoriesError,
    String? productsError,
    String? selectedCategoryId,
    bool? isSubmittingReview,
    String? submitReviewError,
    bool? reviewSubmittedSuccessfully,
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
      isSelectedRestaurantFavorite:
          isSelectedRestaurantFavorite ?? this.isSelectedRestaurantFavorite,
      isSubmittingReview: isSubmittingReview ?? this.isSubmittingReview,
      submitReviewError: submitReviewError ?? this.submitReviewError,
      reviewSubmittedSuccessfully:
          reviewSubmittedSuccessfully ?? this.reviewSubmittedSuccessfully,
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
        isSelectedRestaurantFavorite,
        isSubmittingReview,
        submitReviewError,
        reviewSubmittedSuccessfully,
      ];
}
