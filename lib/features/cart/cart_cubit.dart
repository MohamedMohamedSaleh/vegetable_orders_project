import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetable_orders_project/core/logic/dio_helper.dart';
import 'package:vegetable_orders_project/core/logic/helper_methods.dart';
import 'package:vegetable_orders_project/features/cart/cart_model.dart';
import 'package:vegetable_orders_project/features/cart/cart_states.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartStates());

  List<CartModel> cartModel = [];
  Future<void> storeProduct({required int id}) async {
    emit(AddToCartLoadingState());
    final response = await DioHelper().sendData(endPoint: "client/cart", data: {
      "product_id": "$id",
      "amount": "1",
    });

    if (response.isSuccess) {
      final model = AddProductData.fromJson(response.response!.data);
      showMessage(
        message: response.message,
        type: MessageType.success,
      );
      showCart();
      emit(AddToCartSuccessState());

    } else {
      emit(AddToCartFailedState());
      showMessage(message: 'لم يتم إضافة المنتج');
    }
  }

  Future<void> showCart() async {
    emit(GetCartLoadingState());
    final response = await DioHelper().getData(endPoint: "client/cart");

    if (response.isSuccess) {
      showMessage(
        message: response.message,
        type: MessageType.success,
      );
      final model = CartData.fromJson(response.response!.data);
      cartModel = model.list;
      emit(GetCartStuccessState(model: model));
    } else {
      emit(GetCartFailedState());
      showMessage(message: 'Failed');
    }
  }

  Future<void> deleteProduct({required int id}) async {
    emit(DeleteFromCartLoadingState());
    final response =
        await DioHelper().deleteData(endPoint: 'client/cart/delete_item/$id');

    if (response.isSuccess) {
      showCart();

      cartModel.removeWhere((element) => element.id == id);

      emit(DeleteFromCartSuccessState());
      showMessage(message: 'success', type: MessageType.success);
    } else {
      emit(DeleteFromCartFailedState());
    }
  }
}
