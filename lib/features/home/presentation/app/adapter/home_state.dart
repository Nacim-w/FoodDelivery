import 'package:equatable/equatable.dart';
import 'package:legy/features/home/model/nearby_restaurant_model.dart';
import 'package:legy/features/home/model/top_category_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  const HomeLoaded({required this.categories});

  final List<TopCategoryModel> categories;

  @override
  List<Object> get props => [categories];
}

class HomeError extends HomeState {
  const HomeError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
