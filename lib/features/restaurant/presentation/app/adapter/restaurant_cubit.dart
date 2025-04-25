import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_state.dart';
import 'package:legy/features/restaurant/service/restaurant_service.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final RestaurantService restaurantsService;

  // Flag to track if the cubit is closed
  bool _isClosed = false;

  RestaurantCubit({required this.restaurantsService})
      : super(RestaurantsInitial());

  @override
  Future<void> close() {
    _isClosed = true;
    return super.close();
  }

  // Check if the cubit is closed before emitting
  void _safeEmit(RestaurantState state) {
    if (!_isClosed) {
      emit(state);
    }
  }

  Future<void> loadRestaurants() async {
    _safeEmit(RestaurantsLoading());

    try {
      final restaurants = await restaurantsService.getRestaurants();
      _safeEmit(RestaurantsLoaded(restaurants: restaurants));
    } catch (e) {
      _safeEmit(RestaurantsError(message: e.toString()));
    }
  }

  Future<void> loadRestaurantById(String restaurantId) async {
    _safeEmit(RestaurantsLoading());

    try {
      final restaurant =
          await restaurantsService.getRestaurantById(restaurantId);
      _safeEmit(RestaurantLoaded(restaurant: restaurant));
    } catch (e) {
      _safeEmit(RestaurantsError(message: e.toString()));
    }
  }
}
