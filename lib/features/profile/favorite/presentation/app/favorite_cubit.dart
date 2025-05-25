import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/profile/favorite/model/favorite_product_model.dart';
import 'package:legy/features/profile/favorite/model/favorite_restaurant_model.dart';
import 'package:legy/features/profile/favorite/presentation/app/favorite_state.dart';
import 'package:legy/features/profile/favorite/service/favorite_service.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteService favoriteService;

  FavoriteCubit({required this.favoriteService}) : super(FavoriteInitial());

  Future<void> fetchFavorites() async {
    emit(FavoriteLoading());
    try {
      final restaurantFuture = favoriteService.getFavoriteRestaurant();
      final productFuture = favoriteService.getFavoriteProduct();

      final restaurantResponse = await restaurantFuture;
      final productResponse = await productFuture;

      final decodedRestaurantJson = jsonDecode(restaurantResponse);
      final restaurantListJson =
          decodedRestaurantJson['content'] as List<dynamic>? ?? [];
      final restaurantList = restaurantListJson
          .map((json) => FavoriteRestaurantModel.fromJson(json))
          .toList();

      final decodedProductJson = jsonDecode(productResponse);
      final productListJson =
          decodedProductJson['content'] as List<dynamic>? ?? [];
      final productList = productListJson
          .map((json) => FavoriteProductModel.fromJson(json))
          .toList();
      emit(FavoriteLoaded(
        favoriteRestaurants: restaurantList,
        favoriteProducts: productList,
      ));
    } catch (e) {
      emit(FavoriteError(message: e.toString()));
    }
  }
}
