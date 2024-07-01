import 'dart:core';

import 'package:add_to_cart/data/model/product_model.dart';

class FavoriteModel {
  List<ProductModel> product = [];
  FavoriteModel({
    required this.product,
  });
  FavoriteModel copyWith({
    List<ProductModel>? product,
  }) {
    return FavoriteModel(product: product ?? this.product);
  }
}
