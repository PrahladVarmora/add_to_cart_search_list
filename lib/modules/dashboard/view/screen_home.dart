import 'package:darshan_vachhani_flutter_yudiz/modules/core/utils/core_import.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/dashboard/bloc/search_result_list/search_result_list_bloc.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/dashboard/model/model_search_result_list.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/dashboard/view/widget/row_product_item.dart';

import '../bloc/cart_list/cart_list_bloc.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  ValueNotifier<bool> mLoading = ValueNotifier(false);
  ValueNotifier<String> mSearchKey = ValueNotifier('');
  TextEditingController searchController = TextEditingController();
  ValueNotifier<List<ProductData>> mSearchResultList = ValueNotifier([]);
  final OutlineInputBorder mOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimens.margin12),
    borderSide: const BorderSide(width: Dimens.margin1),
  );

  @override
  void initState() {
    geSearchResultListEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiValueListenableBuilder(
        valueListenables: [
          mLoading,
          mSearchResultList,
          mSearchKey,
        ],
        builder: (context, values, child) {
          return ModalProgressHUD(
            inAsyncCall: mLoading.value,
            child: BlocListener<SearchResultListBloc, SearchResultListState>(
              listener: (context, state) {
                if (searchController.text.isEmpty &&
                    mSearchResultList.value.isEmpty) {
                  mLoading.value = state is SearchResultListLoading;
                }

                if (state is SearchResultListResponse) {
                  mSearchResultList.value =
                      state.mModelSearchResultList.productData ?? [];

                  mLoading.value = false;
                }
              },
              child: BlocBuilder<CartListBloc, CartListState>(
                builder: (context, state) {
                  return Scaffold(
                    appBar: AppBar(title: const Text(APPStrings.appName)),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.margin16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(APPStrings.textProductList,
                              style: TextStyle(fontSize: Dimens.textSize24)),
                          const SizedBox(height: Dimens.margin10),
                          TextField(
                            autofocus: false,
                            controller: searchController,
                            onChanged: (val) {
                              mSearchKey.value = val;
                            },
                            decoration: InputDecoration(
                              hintText: APPStrings.hintSearch,
                              contentPadding:
                                  const EdgeInsets.all(Dimens.margin15),
                              enabledBorder: mOutlineInputBorder,
                              focusedBorder: mOutlineInputBorder,
                              disabledBorder: mOutlineInputBorder,
                              border: mOutlineInputBorder,
                            ),
                          ),
                          const SizedBox(height: Dimens.margin10),
                          Expanded(
                            child: ListView.separated(
                              itemCount: (mSearchKey.value.isEmpty
                                      ? mSearchResultList.value
                                      : (mSearchResultList.value
                                          .where((element) =>
                                              (element.name ?? '')
                                                  .toLowerCase()
                                                  .contains(mSearchKey.value
                                                      .toLowerCase()))
                                          .toList()))
                                  .length,
                              itemBuilder: (context, index) {
                                return RowProduct(
                                    mSearchResult: (mSearchKey.value.isEmpty
                                        ? mSearchResultList.value
                                        : (mSearchResultList.value
                                            .where((element) =>
                                                (element.name ?? '')
                                                    .toLowerCase()
                                                    .contains(mSearchKey.value
                                                        .toLowerCase()))
                                            .toList()))[index]);
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: Dimens.margin10);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    floatingActionButton: BlocProvider.of<CartListBloc>(context)
                            .mCartList
                            .isNotEmpty
                        ? FloatingActionButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.routesCart);
                            },
                            child: Badge(
                                label: Text(
                                    BlocProvider.of<CartListBloc>(context)
                                        .mCartList
                                        .length
                                        .toString()),
                                child: const Icon(Icons.shopping_cart)),
                          )
                        : null,
                  );
                },
              ),
            ),
          );
        });
  }

  void geSearchResultListEvent() async {
    BlocProvider.of<SearchResultListBloc>(getNavigatorKeyContext())
        .add(GetSearchResultList(url: AppUrls.apiResults));
  }

  void searchListener() {}
}
