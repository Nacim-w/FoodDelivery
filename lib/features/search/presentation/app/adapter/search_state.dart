part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<SearchModel> searchResults;

  const SearchSuccess(this.searchResults);

  @override
  List<Object> get props => [searchResults];
}

class SearchError extends SearchState {
  final String errorMessage;

  const SearchError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
