import 'package:equatable/equatable.dart';
import 'package:legy/features/restaurant/model/restaurant_model.dart';

abstract class RestaurantState extends Equatable {
  @override
  List<Object> get props => [];
}

class RestaurantsInitial extends RestaurantState {}

class RestaurantsLoading extends RestaurantState {}

class RestaurantsLoaded extends RestaurantState {
  final List<RestaurantModel> restaurants;

  RestaurantsLoaded({required this.restaurants});

  @override
  List<Object> get props => [restaurants];
}

class RestaurantLoaded extends RestaurantState {
  final RestaurantModel restaurant;

  RestaurantLoaded({required this.restaurant});

  @override
  List<Object> get props => [restaurant];
}

class RestaurantsError extends RestaurantState {
  final String message;

  RestaurantsError({required this.message});

  @override
  List<Object> get props => [message];
}
