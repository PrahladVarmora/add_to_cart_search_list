import 'package:darshan_vachhani_flutter_yudiz/modules/core/utils/core_import.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/dashboard/model/model_search_result_list.dart';

import '../../../core/utils/api_import.dart';

part 'cart_list_event.dart';

part 'cart_list_state.dart';

class CartListBloc extends Bloc<CartListEvent, CartListState> {
  CartListBloc() : super(CartListInitial()) {
    mCartList = [];
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);
  }

  late List<ProductData> mCartList;

  _onAddToCart(AddToCart event, Emitter<CartListState> emit) {
    emit(CartListLoading());
    mCartList.add(event.product);
    emit(CartListResponse(productDataList: mCartList));
  }

  _onRemoveFromCart(RemoveFromCart event, Emitter<CartListState> emit) {
    emit(CartListLoading());
    mCartList.remove(event.product);
    emit(CartListResponse(productDataList: mCartList));
  }

  _onClearCart(ClearCart event, Emitter<CartListState> emit) {
    emit(CartListLoading());
    mCartList = [];
    Navigator.pushNamedAndRemoveUntil(
      getNavigatorKeyContext(),
      AppRoutes.routesSuccess,
      (route) => route.settings.name == AppRoutes.routesHome,
    );
    emit(CartListResponse(productDataList: mCartList));
  }
}
