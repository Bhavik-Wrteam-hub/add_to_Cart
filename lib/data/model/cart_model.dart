// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:add_to_cart/data/model/product_model.dart';

class CartModel {
  int qty;
  int id;
  String name;
  int price;
  String pic;
  ProductModel? serchproduct;
  CartModel(
      {required this.qty,
      required this.id,
      required this.name,
      required this.price,
      required this.pic,
      this.serchproduct});
  CartModel copyWith(
      {int? qty,
      int? id,
      String? name,
      int? price,
      String? pic,
      ProductModel? serchproduct}) {
    return CartModel(
        qty: qty ?? this.qty,
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        pic: pic ?? this.pic,
        serchproduct: serchproduct ?? this.serchproduct);
  }
}
