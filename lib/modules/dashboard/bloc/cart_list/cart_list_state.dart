part of 'cart_list_bloc.dart';

abstract class CartListState extends Equatable {
  const CartListState();
}

class CartListLoading extends CartListState {
  @override
  List<Object?> get props => [];
}

class CartListInitial extends CartListState {
  @override
  List<Object> get props => [];
}

/// [CartListResponse] class is used SearchResultList State Response
class CartListResponse extends CartListState {
  final List<ProductData> productDataList;

  const CartListResponse({required this.productDataList});

  @override
  List<Object> get props => [productDataList];
}
