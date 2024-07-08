// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:add_to_cart/data/model/product_model.dart';

class FavoriteModel {
  List<ProductModel>? product = [];
  List<ProductModel>? serchproduct;

  FavoriteModel({this.product, this.serchproduct});
  FavoriteModel copywith(
      {List<ProductModel>? product, List<ProductModel>? serchproduct}) {
    return FavoriteModel(
        product: product ?? this.product,
        serchproduct: serchproduct ?? this.serchproduct);
  }
}
