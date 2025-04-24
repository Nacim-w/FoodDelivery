import 'package:equatable/equatable.dart';
import 'package:legy/features/restaurant/model/restaurant_model.dart';

abstract class RestaurantState extends Equatable {
  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final List<RestaurantModel> restaurants;

  RestaurantLoaded({required this.restaurants});

  @override
  List<Object> get props => [restaurants];
}

class RestaurantError extends RestaurantState {
  final String message;

  RestaurantError({required this.message});

  @override
  List<Object> get props => [message];
}
