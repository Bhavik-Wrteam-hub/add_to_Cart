import 'package:add_to_cart/model/favorite_model.dart';
import 'package:add_to_cart/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<ProductModel> {
  CounterCubit() : super(ProductModel(count: 0));

  conterIncrement(ProductModel product) {
    print(product.name);
    print(state.name);
    emit(state.counter(Count: product.count += 1));
    print("Increment");
    print(state.count);
  }

  conterDecrement(ProductModel product) {
    if (state.count != 0) {
      emit(state.counter(Count: product.count -= 1));
      print("Decrement");
      print(state.count);
    }
  }
}
