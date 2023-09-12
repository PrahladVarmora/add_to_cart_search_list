import 'package:darshan_vachhani_flutter_yudiz/modules/core/utils/api_import.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/core/utils/core_import.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/dashboard/bloc/search_result_list/search_result_list_bloc.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/dashboard/repository/repository_search_result_list.dart';
import 'package:http/http.dart' as http;

import 'modules/dashboard/bloc/cart_list/cart_list_bloc.dart';

class BlocGenerator {
  static late ApiProvider apiProvider;
  static late http.Client client;

  static void load() {
    apiProvider = ApiProvider();
    client = http.Client();
  }

  static generateBloc() {
    return [
      BlocProvider<SearchResultListBloc>(
        create: (BuildContext context) => SearchResultListBloc(
            apiProvider: apiProvider,
            client: client,
            repository: RepositorySearchResultList()),
      ),
      BlocProvider<CartListBloc>(
        create: (BuildContext context) => CartListBloc(),
      ),
    ];
  }
}
