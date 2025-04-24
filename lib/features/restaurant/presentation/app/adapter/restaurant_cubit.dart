import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_state.dart';
import 'package:legy/features/restaurant/service/restaurant_service.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final RestaurantService restaurantService;

  RestaurantCubit({required this.restaurantService})
      : super(RestaurantInitial());

  Future<void> loadRestaurants() async {
    emit(RestaurantLoading());

    try {
      final restaurants = await restaurantService.getRestaurants();
      emit(RestaurantLoaded(restaurants: restaurants));
    } catch (e) {
      emit(RestaurantError(message: e.toString()));
    }
  }
}
