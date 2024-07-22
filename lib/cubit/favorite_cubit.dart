// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:add_to_cart/cubit/cart_cubit.dart';
import 'package:add_to_cart/data/repository/favoriteRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:add_to_cart/data/model/favorite_model.dart';
import 'package:add_to_cart/data/model/product_model.dart';

class FavoriteCubit extends Cubit<FavoriteModel> {
  FavoriteCubit() : super(FavoriteModel(product: []));

  void addFavoriteList({ ProductModel? product}) async {
    try {
      int index = state.product!.indexWhere(
        (p) => p.id == product!.id,
      );
      if (index != -1) {
        print("this is index if :- $index");
        return;
      } else {
        print("this is index else :- $index");
        emit(state.copywith(product: state.product!..add(product!)));
      }
    } catch (e) {
      print("This is error :- $e");
    }
  }

  void removeFavoriteList({required int id}) async {
    try {
      emit(state.copywith(
          product: state.product!
            ..removeWhere(
              (e) => e.id == id,
            )));

      print("Remove Favorite List");
    } catch (e) {
      print(e.toString());
    }
  }

  bool inFavoriteList(ProductModel product) {
    bool infavoriteList = state.product!.any(
      (p) => p.id == product.id,
    );
    print("this is the in favorite list $infavoriteList");
    return infavoriteList;
  }
}
