import 'package:add_to_cart/model/favorite_model.dart';
import 'package:add_to_cart/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<FavoriteModel> {
  FavoriteCubit() : super(FavoriteModel(product: []));

  void addFavoriteList({required ProductModel product}) async {
    print(product.name);
    try {
      emit(state.copyWith(product: state.product..add(product)));
      print("Add Favorite List");
    } catch (e) {
      print(e.toString());
    }
  }

  void removeFavoriteList({required ProductModel product}) async {
    try {
      print(product.name);
      emit(state.copyWith(product: state.product..remove(product)));
      print("Remove Favorite List");
    } catch (e) {
      print(e.toString());
    }
  }

  bool inFavoriteList(ProductModel product) {
    bool flag = state.product.any((p) => p.id == product.id);

    print("This is flag :- $flag");
    return flag;
  }
}
