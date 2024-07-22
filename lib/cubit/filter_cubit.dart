import 'package:add_to_cart/data/model/favorite_model.dart';
import 'package:add_to_cart/data/model/product_model.dart';
import 'package:add_to_cart/data/repository/product_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCubit extends Cubit<FavoriteModel> {
  FilterCubit() : super(FavoriteModel(serchproduct:[]));

  List<ProductModel> filterProductsByName(String enterkeyword) {
    List<ProductModel> resultproduct = [];
    if (enterkeyword.isEmpty) {
      resultproduct = Const.product;
    } else {
      resultproduct = Const.product
          .where((product) =>
              product.name.toLowerCase().contains(enterkeyword.toLowerCase()))
          .toList();
      emit(state.copywith(serchproduct: resultproduct));
    }
    return resultproduct;
  }
}
