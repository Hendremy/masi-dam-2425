import 'package:bloc/bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/model/shop_item.dart';
import 'package:meta/meta.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {

  final ShopApi shopApi;

  ShopCubit(this.shopApi) : super(ShopInitial()) {
    shopApi.productsStream.listen(
          (products) => emit(ShopLoaded(products)),
      onError: (error) => emit(ShopError(error.toString())),
    );
  }

  Future<void> loadProducts() async {
    try {
      emit(ShopLoading());
      await shopApi.loadItems();
    } catch (e) {
      emit(ShopError(e.toString()));
    }
  }
}
