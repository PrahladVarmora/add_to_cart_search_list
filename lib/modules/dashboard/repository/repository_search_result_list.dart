import 'package:darshan_vachhani_flutter_yudiz/modules/core/common/model/model_common_api_message.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/core/utils/api_import.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/dashboard/model/model_search_result_list.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class RepositorySearchResultList {
  static final RepositorySearchResultList _repository =
      RepositorySearchResultList._internal();

  factory RepositorySearchResultList() {
    return _repository;
  }

  RepositorySearchResultList._internal();

  Future<Either<ModelProductList, ModelCommonAPIMessage>>
      callSearchResultListApi(
          String url, ApiProvider mApiProvider, http.Client client) async {
    Either<dynamic, ModelCommonAPIMessage> response =
        await mApiProvider.callGetMethod(
      client,
      url,
      {},
    );
    return response.fold(
      (success) {
        try {
          ModelProductList result =
              ModelProductList.fromJson(jsonDecode(success));
          return left(result);
        } catch (e) {
          return right(ModelCommonAPIMessage(message: e.toString()));
        }
      },
      (error) => right(error),
    );
  }
}
