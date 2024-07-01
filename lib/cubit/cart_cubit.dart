import 'dart:io';

import 'package:add_to_cart/data/model/cart_model.dart';
import 'package:add_to_cart/data/model/favorite_model.dart';
import 'package:add_to_cart/data/model/product_model.dart';
import 'package:add_to_cart/data/repository/cartRepository.dart';
import 'package:add_to_cart/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/widgets.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartInProgres extends CartState {}

class CartInSuccess extends CartState {
  final List<CartModel> cartitem;
  CartInSuccess({required this.cartitem});
}

class CartInerror extends CartState {
  final String error;
  CartInerror({required this.error});
}

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository = CartRepository();
  CartCubit() : super(CartInitial());

  Future<void> fetchCartItems() async {
    emit(CartInProgres());
    try {
      final cartItems = await _cartRepository.getCartItems();
      emit(CartInSuccess(cartitem: cartItems));
    } catch (e) {
      emit(CartInerror(error: e.toString()));
    }
  }

  void addCartList({required ProductModel product}) async {
    print(product.name);
    try {
      if (state is CartInSuccess) {
        List<CartModel> cartItem = (state as CartInSuccess).cartitem;
        final cartItemIndex = cartItem.indexWhere(
          (cartItem) => cartItem.id == product.id,
        );
        if (cartItemIndex != -1) {
          cartItem[cartItemIndex] = cartItem[cartItemIndex].copyWith(
            qty: cartItem[cartItemIndex].qty + 1,
          );
        } else {
          cartItem.add(
            CartModel(
              qty: 1,
              id: product.id,
              name: product.name,
              price: product.price,
              pic: product.pic,
            ),
          );

          emit(CartInSuccess(cartitem: cartItem));
          print("Add Cart List");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void removeFromCart({required int cartItemId}) {
    if (state is CartInSuccess) {
      List<CartModel> cartItems = (state as CartInSuccess).cartitem;

      final cartItemIndex = cartItems.indexWhere(
        (cartItem) => cartItem.id == cartItemId,
      );

      if (cartItemIndex != -1) {
        cartItems.removeAt(cartItemIndex);
        emit(CartInSuccess(cartitem: cartItems));
      }
    }
  }

  void decreaseQuantityOfCartItem(int productId) {
    if (state is CartInSuccess) {
      List<CartModel> cartItems = (state as CartInSuccess).cartitem;

      ///[Decrease the quantity of the product in cart if it exists]
      final cartItemIndex = cartItems.indexWhere(
        (cartItem) => cartItem.id == productId,
      );

      if (cartItemIndex != -1) {
        if (cartItems[cartItemIndex].qty > 1) {
          cartItems[cartItemIndex] = cartItems[cartItemIndex].copyWith(
            qty: cartItems[cartItemIndex].qty - 1,
          );
        } else {
          cartItems.removeAt(cartItemIndex);
        }
        emit(CartInSuccess(cartitem: cartItems));
      }
    }
  }

  void increceQuantityOfCartItem({required int productId}) {
    if (state is CartInSuccess) {
      List<CartModel> cartItems = (state as CartInSuccess).cartitem;

      ///[Decrease the quantity of the product in cart if it exists]
      final cartItemIndex = cartItems.indexWhere(
        (cartItem) => cartItem.id == productId,
      );

      cartItems[cartItemIndex] = cartItems[cartItemIndex].copyWith(
        qty: cartItems[cartItemIndex].qty + 1,
      );

      print("Card added");

      emit(CartInSuccess(cartitem: cartItems));
    }
  }

  // bool isProductInCart(int productId) {
  //   if (state is CartInSuccess) {
  //     List<CartModel> cartItems = (state as CartInSuccess).cartitem;

  //     return cartItems.any((cartItem) => cartItem.id == productId);
  //   }
  //   return false;
  // }

  // void removeCartList({required ProductModel product}) async {
  //   try {
  //     print(product.name);
  //     emit(state.copyWith(product: state.product!..remove(product)));
  //     emit(state.copyWith(count: product.qty = 0));
  //     print("Remove Cart List");
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  bool isProductInCart(int productId) {
    if (state is CartInSuccess) {
      List<CartModel> cartItems = (state as CartInSuccess).cartitem;

      return cartItems.any((cartItem) => cartItem.id == productId);
    }
    return false;
  }

  // int totalAmount(CartModel product) {
  //   int total = 0;
  //   for (var element in product) {
  //     total += element.price! * element.qty;
  //   }
  //   return total;
  // }


  double totalAmount() {
    return (state as CartInSuccess).cartitem.fold(
          0.0,
          (double total, CartModel cartItem) =>
              total + cartItem.price * cartItem.qty,
        );
  }

  // List<ProductModel> filterProductsByPrice(String enterkeyword) {
  //   List<ProductModel> resultproduct = [];
  //   if (enterkeyword.isEmpty) {
  //     resultproduct = Const.product;
  //   } else {
  //     resultproduct = Const.product
  //         .where((product) =>
  //             product.name!.toLowerCase().contains(enterkeyword.toLowerCase()))
  //         .toList();
  //     emit(state.copyWith(serchproduct: resultproduct));
  //   }
  //   return resultproduct;
  // }

  Future<void> pdf() async {
    final pdf = pw.Document();
    final dic = await getApplicationDocumentsDirectory();
    final path = '${dic.path}/bill.pdf';
    final font = await rootBundle.load("assets/open-sans.ttf");
    final ttf = Font.ttf(font);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!',
              style: pw.TextStyle(fontSize: 20, font: ttf)),
        ),
      ),
    );
    final file = File(path);
    await file.writeAsBytes(await pdf.save());
    print("File Download succerssfull");
  }
}
