

import 'package:add_to_cart/data/model/cart_model.dart';

class CartRepository {
  Future<List<CartModel>> getCartItems() async {
    await Future.delayed(const Duration(seconds: 1));
    return List<CartModel>.from([]);
  }

  // Future<void> addToCart() async {
  //   await Future.delayed(const Duration(seconds: 1));
  // }

  // Future<void> removeFromCart() async {
  //   await Future.delayed(const Duration(seconds: 1));
  // }
}
