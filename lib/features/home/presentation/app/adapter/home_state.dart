import 'package:equatable/equatable.dart';
import 'package:legy/features/home/model/home_profile_model.dart';
import 'package:legy/features/home/model/nearby_restaurant_model.dart';
import 'package:legy/features/home/model/top_category_model.dart';

class HomeState extends Equatable {
  final List<TopCategoryModel>? categories;
  final List<NearbyRestaurantModel>? restaurants;
  final bool isLoadingCategories;
  final bool isLoadingRestaurants;
  final String? categoriesError;
  final String? restaurantsError;
  final HomeProfileModel? profile;

  const HomeState({
    this.categories,
    this.restaurants,
    this.isLoadingCategories = false,
    this.isLoadingRestaurants = false,
    this.categoriesError,
    this.restaurantsError,
    this.profile,
  });

  HomeState copyWith({
    List<TopCategoryModel>? categories,
    List<NearbyRestaurantModel>? restaurants,
    bool? isLoadingCategories,
    bool? isLoadingRestaurants,
    String? categoriesError,
    String? restaurantsError,
    HomeProfileModel? profile,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      restaurants: restaurants ?? this.restaurants,
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      isLoadingRestaurants: isLoadingRestaurants ?? this.isLoadingRestaurants,
      categoriesError: categoriesError ?? this.categoriesError,
      restaurantsError: restaurantsError ?? this.restaurantsError,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        restaurants,
        isLoadingCategories,
        isLoadingRestaurants,
        categoriesError,
        restaurantsError,
        profile,
      ];
}
