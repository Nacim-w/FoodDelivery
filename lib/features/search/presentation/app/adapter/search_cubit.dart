import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/search/model/search_model.dart';
import 'package:legy/features/search/service/search_service.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchService}) : super(SearchInitial());

  final SearchService searchService;

  Future<void> search(String query) async {
    emit(SearchLoading());
    try {
      final searchResults = await searchService.search(query);
      emit(SearchSuccess(searchResults));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
