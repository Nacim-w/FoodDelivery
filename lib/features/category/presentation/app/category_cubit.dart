import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/category/service/category_service.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryService categoryService;

  CategoryCubit({required this.categoryService}) : super(CategoryInitial());

  Future<void> fetchPopularRestaurants(int selectedIndex) async {
    emit(CategoryLoading());

    final mainValues = ['SENEGALESE', 'INTERNATIONALE', 'SAINE'];
    final selectedMain = mainValues[selectedIndex];

    try {
      final restaurants = await categoryService.getPopularRestaurants(
        main: selectedMain, // passing the correct main value
      );
      emit(CategoryLoaded(restaurants));
    } catch (e) {
      emit(const CategoryError(
          "Erreur lors du chargement des restaurants populaires."));
    }
  }
}
