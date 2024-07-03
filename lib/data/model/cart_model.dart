// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

class CartModel {
  int qty;
  int id;
  String name;
  int price;
  String pic;
  CartModel({
    required this.qty,
    required this.id,
    required this.name,
    required this.price,
    required this.pic,
  });
  CartModel copyWith({
    int? qty,
    int? id,
    String? name,
    int? price,
    String? pic,
  }) {
    return CartModel(
      qty: qty ?? this.qty,
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      pic: pic ?? this.pic,
    );
  }
}
