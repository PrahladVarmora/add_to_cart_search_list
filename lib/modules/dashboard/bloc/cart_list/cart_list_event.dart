part of 'cart_list_bloc.dart';

abstract class CartListEvent extends Equatable {
  const CartListEvent();
}

class AddToCart extends CartListEvent {
  const AddToCart({required this.product});

  final ProductData product;

  @override
  List<Object> get props => [product];
}

class RemoveFromCart extends CartListEvent {
  const RemoveFromCart({required this.product});

  final ProductData product;

  @override
  List<Object> get props => [product];
}

class ClearCart extends CartListEvent {
  const ClearCart();

  @override
  List<Object> get props => [];
}
