import 'dart:core';

import 'package:add_to_cart/model/product_model.dart';

class CartModel {
  List<ProductModel>? product = [];
  int count;
  int total;

  CartModel({ this.product, this.count = 0 , this.total = 0});
  CartModel copyWith({List<ProductModel>? product, int count = 0 , total =0}) {
    return CartModel(product: product ?? this.product, count: count,total: total);
  }
}
