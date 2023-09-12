import 'package:darshan_vachhani_flutter_yudiz/modules/core/common/model/model_common_api_message.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/core/utils/core_import.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/dashboard/model/model_search_result_list.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/dashboard/repository/repository_search_result_list.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/api_import.dart';

part 'search_result_list_event.dart';

part 'search_result_list_state.dart';

/// Notifies the [SearchResultListBloc] of a new [SearchResultListEvent] which triggers
/// [RepositoryJob] This class used to API and bloc connection.
/// [ApiProvider] class is used to network API call.
class SearchResultListBloc
    extends Bloc<SearchResultListEvent, SearchResultListState> {
  SearchResultListBloc({
    required RepositorySearchResultList repository,
    required ApiProvider apiProvider,
    required http.Client client,
  })  : mRepositorySearchResultList = repository,
        mApiProvider = apiProvider,
        mClient = client,
        super(SearchResultListInitial()) {
    on<GetSearchResultList>(_onGetSearchResultList);
  }

  final RepositorySearchResultList mRepositorySearchResultList;
  final ApiProvider mApiProvider;
  final http.Client mClient;

  /// Notifies the [_onGetSearchResultList] of a new [GetSearchResultList] which triggers
  void _onGetSearchResultList(
    GetSearchResultList event,
    Emitter<SearchResultListState> emit,
  ) async {
    emit(SearchResultListLoading());
    try {
      /// This is a way to handle the response from the API call.
      Either<ModelProductList, ModelCommonAPIMessage> response =
          await mRepositorySearchResultList.callSearchResultListApi(
              event.url, mApiProvider, mClient);
      response.fold(
        (success) {
          emit(SearchResultListResponse(mModelSearchResultList: success));
        },
        (error) {
          ToastController.showToast(
              error.message.toString(), getNavigatorKeyContext(), false);

          emit(SearchResultListFailure(mError: error.message!));
        },
      );
    } on SocketException {
      ToastController.showToast(ValidationString.validationNoInternetFound,
          getNavigatorKeyContext(), false);
      emit(const SearchResultListFailure(
          mError: ValidationString.validationNoInternetFound));
    } catch (e) {
      ToastController.showToast(e.toString(), getNavigatorKeyContext(), false);
      if (e.toString().contains(ValidationString.validationXMLHttpRequest)) {
        emit(const SearchResultListFailure(
            mError: ValidationString.validationNoInternetFound));
      } else {
        emit(const SearchResultListFailure(
            mError: ValidationString.validationInternalServerIssue));
      }
    }
  }
}
