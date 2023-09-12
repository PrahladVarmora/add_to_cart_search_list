part of 'search_result_list_bloc.dart';

/// [SearchResultListEvent] abstract class is used Event of bloc.
abstract class SearchResultListEvent extends Equatable {
  const SearchResultListEvent();

  @override
  List<Object> get props => [];
}

/// [GetSearchResultList] abstract class is used Auth Event
class GetSearchResultList extends SearchResultListEvent {
  const GetSearchResultList({
    required this.url,
  });

  final String url;

  @override
  List<Object> get props => [url];
}
