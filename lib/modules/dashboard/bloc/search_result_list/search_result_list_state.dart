part of 'search_result_list_bloc.dart';

/// [SearchResultListState] abstract class is used SearchResultList State
abstract class SearchResultListState extends Equatable {
  const SearchResultListState();

  @override
  List<Object> get props => [];
}

/// [SearchResultListInitial] class is used SearchResultList State Initial
class SearchResultListInitial extends SearchResultListState {}

/// [SearchResultListLoading] class is used SearchResultList State Loading
class SearchResultListLoading extends SearchResultListState {}

/// [SearchResultListResponse] class is used SearchResultList State Response
class SearchResultListResponse extends SearchResultListState {
  final ModelProductList mModelSearchResultList;

  const SearchResultListResponse({required this.mModelSearchResultList});

  @override
  List<Object> get props => [mModelSearchResultList];
}

/// [SearchResultListFailure] class is used SearchResultList State Failure
class SearchResultListFailure extends SearchResultListState {
  final String mError;

  const SearchResultListFailure({required this.mError});

  @override
  List<Object> get props => [mError];
}
