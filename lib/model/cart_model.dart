import 'dart:core';

import 'package:add_to_cart/model/product_model.dart';

class CartModel {
  List<ProductModel>? product = [];
  List<ProductModel>? serchproduct = [];
  int count;
  int total;

  CartModel({this.product, this.count = 0, this.total = 0, this.serchproduct});
  CartModel copyWith(
      {List<ProductModel>? product,
      int count = 0,
      total = 0,
      List<ProductModel>? serchproduct}) {
    return CartModel(
      product: product ?? this.product,
      count: count,
      total: total,
      serchproduct: serchproduct ?? this.serchproduct,
    );
  }
}
