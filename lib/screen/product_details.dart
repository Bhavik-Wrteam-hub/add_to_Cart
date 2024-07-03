import 'package:add_to_cart/cubit/favorite_cubit.dart';
import 'package:add_to_cart/data/model/product_model.dart';
import 'package:add_to_cart/screen/add_cart_screen.dart';
import 'package:add_to_cart/screen/favorite_list_screen.dart';
import 'package:add_to_cart/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatefulWidget {
  ProductModel productModel;
  ProductDetails({super.key, required this.productModel});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.productModel.pic),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50, left: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(2, 1),
                                      color: Color.fromARGB(255, 156, 154, 154),
                                      blurRadius: 2.0)
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Color.fromARGB(255, 247, 245, 238),
                              ),
                              child: Center(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50, right: 10),
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(2, 1),
                                          color: Color.fromARGB(
                                              255, 156, 154, 154),
                                          blurRadius: 2.0)
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Color.fromARGB(255, 247, 245, 238),
                                  ),
                                  child:
                                      BlocBuilder<FavoriteCubit, FavoriteState>(
                                    builder: (context, state) {
                                      final inFavorite = context
                                          .read<FavoriteCubit>()
                                          .inFavoriteList;
                                      return InkWell(
                                        onTap: () {
                                          context
                                              .read<FavoriteCubit>()
                                              .addFavoriteList(
                                                  product: widget.productModel);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              backgroundColor: Colors.white38,
                                              content: Text(
                                                "SuccessFully Add In Favorite",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: inFavorite == true
                                              ? Colors.amber
                                              : Colors.black,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(2, 1),
                                          color: Color.fromARGB(
                                              255, 156, 154, 154),
                                          blurRadius: 2.0)
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Color.fromARGB(255, 247, 245, 238),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AddCartScreen(),
                                          ));
                                    },
                                    child: const Icon(
                                      Icons.shopping_cart,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
