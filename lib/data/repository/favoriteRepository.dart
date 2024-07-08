import 'package:add_to_cart/data/model/favorite_model.dart';
import 'package:add_to_cart/data/model/product_model.dart';

class Favoriterepository {

 static Future<List<FavoriteModel>> getfavoriteitems() async {
    await Future.delayed(Duration(seconds: 1));
    return List<FavoriteModel>.from([]);
  }
}
