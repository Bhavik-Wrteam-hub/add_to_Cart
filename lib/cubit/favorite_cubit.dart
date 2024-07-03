// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:add_to_cart/cubit/cart_cubit.dart';
import 'package:add_to_cart/data/repository/favoriteRepository.dart';
import 'package:add_to_cart/data/repository/product_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:add_to_cart/data/model/favorite_model.dart';
import 'package:add_to_cart/data/model/product_model.dart';

abstract class FavoriteState {}

class FavoriteStateInitial extends FavoriteState {}

class FavoriteStateInProgress extends FavoriteState {}

class FavoriteStateInSuccess extends FavoriteState {
  final List<FavoriteModel> favoriteitem;
  FavoriteStateInSuccess({
    required this.favoriteitem,
  });
}

class FavoriteStateInError extends FavoriteState {
  String error;
  FavoriteStateInError({
    required this.error,
  });
}

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteStateInitial());

  void addFavoriteList({required ProductModel product}) async {
    List<FavoriteModel> favoriteitem = [];

    print("This is the List$favoriteitem");
    try {
      favoriteitem.add(
        FavoriteModel(
            id: product.id,
            name: product.name,
            price: product.price,
            pic: product.pic),
      );

      emit(
        FavoriteStateInSuccess(favoriteitem: favoriteitem),
      );
      print("Add Favorite List");
    } catch (e) {
      print("This is error :- $e");
    }
  }

  Future fatchFavoriteItem() async {
    try {
      if (state is FavoriteStateInSuccess) {
        emit(FavoriteStateInProgress());
        final favorite = await Favoriterepository.getfavoriteitems();

        emit(FavoriteStateInSuccess(favoriteitem: favorite));
      }
    } catch (e) {
      emit(FavoriteStateInError(error: e.toString()));
    }
  }

  void removeFavoriteList({required int product}) async {
    try {
      List<FavoriteModel> favoriteitem =
          (state as FavoriteStateInSuccess).favoriteitem;

      final favoriteTtemindex =
          favoriteitem.indexWhere((favoriteitem) => favoriteitem.id == product);

      print("this is the :- $favoriteTtemindex");
      favoriteitem.removeAt(favoriteTtemindex);
      emit(FavoriteStateInSuccess(favoriteitem: favoriteitem));
      print("Remove Favorite List");
    } catch (e) {
      print(e.toString());
    }
  }

  bool inFavoriteList(int productid) {
    if (state is FavoriteStateInSuccess) {
      List<FavoriteModel> favoriteitem =
          (state as FavoriteStateInSuccess).favoriteitem;
      bool infavoriteList = favoriteitem.any(
        (favoriteitem) => favoriteitem.id == productid,
      );
      print("this is the in favorite list $infavoriteList");
      return infavoriteList;
    }
    return false;
  }
}
