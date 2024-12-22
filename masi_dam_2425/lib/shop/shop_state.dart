part of 'shop_cubit.dart';

@immutable
sealed class ShopState {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopLoading extends ShopState {}

class ShopLoaded extends ShopState {
  final List<ShopItem> products;

  const ShopLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ShopError extends ShopState {
  final String message;

  const ShopError(this.message);

  @override
  List<Object> get props => [message];
}