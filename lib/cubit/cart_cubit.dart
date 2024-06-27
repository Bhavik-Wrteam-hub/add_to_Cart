import 'package:add_to_cart/model/cart_model.dart';
import 'package:add_to_cart/model/favorite_model.dart';
import 'package:add_to_cart/model/product_model.dart';
import 'package:add_to_cart/utils/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartModel> {
  CartCubit() : super(CartModel(product: []));

  void addCartList({required ProductModel product}) async {
    print(product.name);
    try {
      emit(state.copyWith(product: state.product!..add(product)));
      print("Add Cart List");
    } catch (e) {
      print(e.toString());
    }
  }

  void removeCartList({required ProductModel product}) async {
    try {
      print(product.name);
      emit(state.copyWith(product: state.product!..remove(product)));
      emit(state.copyWith(count: product.count = 0));
      print("Remove Cart List");
    } catch (e) {
      print(e.toString());
    }
  }

  bool inCartList(ProductModel product) {
    bool flag = state.product!.any((p) => p.id == product.id);
    return flag;
  }

  int totalAmount() {
    int total = 0;
    for (var element in state.product!) {
      total += element.price! * element.count;
    }
    return total;
  }

  List<ProductModel> filterProductsByPrice(String enterkeyword) {
    List<ProductModel> resultproduct = [];
    if (enterkeyword.isEmpty) {
      resultproduct = Const.product;
    } else {
      resultproduct = Const.product
          .where((product) =>
              product.name!.toLowerCase().contains(enterkeyword.toLowerCase()))
          .toList();
      emit(state.copyWith(serchproduct: resultproduct));
    }
    return resultproduct;
  }
}
