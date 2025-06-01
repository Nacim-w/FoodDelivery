import 'package:equatable/equatable.dart';
import 'package:legy/features/category/model/category_restaurant_model.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryRestaurantModel> restaurants;

  const CategoryLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);

  @override
  List<Object> get props => [message];
}
