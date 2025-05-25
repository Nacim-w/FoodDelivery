import 'package:equatable/equatable.dart';
import 'package:legy/features/profile/favorite/model/favorite_product_model.dart';
import 'package:legy/features/profile/favorite/model/favorite_restaurant_model.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<FavoriteRestaurantModel> favoriteRestaurants;
  final List<FavoriteProductModel> favoriteProducts;

  FavoriteLoaded({
    required this.favoriteRestaurants,
    required this.favoriteProducts,
  });

  @override
  List<Object?> get props => [favoriteRestaurants, favoriteProducts];
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError({required this.message});

  @override
  List<Object?> get props => [message];
}
